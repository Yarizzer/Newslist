//
//  NewsListViewModel.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit

class NewsListViewModel {
    private var userIsSearching: Bool
    private var headlinesArticles: [Article]? {
        didSet {
            shouldUpdateView.value = true
        }
    }
    private var searchedArticles: [Article]? {
        didSet {
            shouldUpdateView.value = true
        }
    }
    var shouldUpdateView: BindableType<Bool?> = BindableType(nil)
    var currentHeadlinesIndex: Int?
    var currentSearchedIndex: Int?
    init() {
        self.userIsSearching = false
        DispatchQueue.global().async {
            NetworkManager.shared.dowloadHeadlinesArticles(completion: { [unowned self] (articles) in
                self.headlinesArticles = articles
            })
        }
    }
    
    private func getArticle() -> Article? {
        if userIsSearching {
            guard let articles = searchedArticles, let currentIndex = currentSearchedIndex else { return nil }
            return  articles[currentIndex]
        } else {
            guard let articles = headlinesArticles, let currentIndex = currentHeadlinesIndex else { return nil }
            return articles[currentIndex]

        }
    }
}

extension NewsListViewModel: NewsListViewModelType {

    var numberOfRows: Int {
        if userIsSearching {
            guard let articles = searchedArticles else { return 0 }
            return articles.count
        } else {
            guard let articles = headlinesArticles else { return 0 }
            return articles.count
        }
    }
    
    var numberOfSections: Int {
        return Constants.numberOsSections
    }
    
    func getNewsListCellViewModel(withIndex index: Int) -> NewsListCellViewModelType? {
        if userIsSearching {
            guard let articles = searchedArticles else { return nil }
            return NewsListCellViewModel(forArticle: articles[index])
        } else {
            guard let articles = headlinesArticles else { return nil }
            return NewsListCellViewModel(forArticle: articles[index])
        }
    }
    
    func setCurrentIndex(withValue value: Int) {
        if userIsSearching {
            self.currentSearchedIndex = value
        } else {
            self.currentHeadlinesIndex = value
        }
    }
    
    func setWatchedMark() {
        guard let article = getArticle() else { return }
        article.watched = true
    }
    
    func getDetailScreenViewModel() -> DetailScreenViewModelType? {
        if userIsSearching {
            guard let index = currentSearchedIndex, let articles = searchedArticles else { return nil }
            return DetailScreenViewModel(forArticle: articles[index])
        } else {
            guard let index = currentHeadlinesIndex, let articles = headlinesArticles else { return nil }
            return DetailScreenViewModel(forArticle: articles[index])
        }
    }
    
    func getReadlistViewModel() -> ReadlistViewModelType? {
        return ReadlistViewModel()
    }
    
    func setUserIsSearching(with value: Bool) {
        self.userIsSearching = value
    }
    
    func searchNews(withText text: String) {
        self.searchedArticles = [Article]()
        let searchKeywords = text.components(separatedBy: " ")
        for keyword in searchKeywords {
            DispatchQueue.global().async {
                NetworkManager.shared.dowloadSearchedArticles(withKeyword: keyword, completion: { [unowned self] (articles) in
                    guard let arrayOfArticles = articles else { return }
                    for article in arrayOfArticles {
                        self.searchedArticles?.append(article)
                    }
                })
            }
        }
    }
    
    func addAtricleToReadList(withIndex index: Int) {
        if userIsSearching {
            guard let articles = searchedArticles else { return }
            DBMainManager.shared.addArticleToReadList(forArticle: articles[index])
        } else {
            guard let articles = headlinesArticles else { return }
            DBMainManager.shared.addArticleToReadList(forArticle: articles[index])
        }
    }
}

extension NewsListViewModel {
    private struct Constants {
        static let numberOsSections = 1
    }
}
