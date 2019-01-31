//
//  ReadlistViewModel.swift
//  NewsList
//
//  Created by Yarr!zzeR on 31/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

class ReadlistViewModel {
    private var articles: [ArticleDBItem]
    private var currentIndex: Int?
    init() {
        articles = DBMainManager.shared.getReadlisItems()
        print(articles.count)
    }
}

extension ReadlistViewModel: ReadlistViewModelType {
    var numberOfRows: Int {
        return articles.count
    }
    
    func updateCurrentIndex(withIndex index: Int) {
        self.currentIndex = index
    }
    
    func updateArticles() {
        self.articles = DBMainManager.shared.getReadlisItems()
    }
    
    func getReadlistCellViewModel(withIndex index: Int) -> ReadlistCellViewModelType {
        return ReadlistCellViewModel(forArticle: articles[index])
    }
    
    func getDetailScreenViewModel() -> DetailScreenViewModelType? {
        guard let index = currentIndex else { return nil }
        return DetailScreenViewModel(forDBArticle: articles[index])
    }
    
    func removeReadList() {
        guard let index = currentIndex else { return }
        DBMainManager.shared.removeRecords(forArticle: articles[index])
        updateArticles()
    }
}
