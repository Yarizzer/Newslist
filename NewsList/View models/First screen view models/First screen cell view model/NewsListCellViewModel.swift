//
//  NewsListCellViewModel.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit

class NewsListCellViewModel {
    private var article: Article
    var articleImage: BindableType<UIImage?> = BindableType(nil)
    init(forArticle article: Article) {
        self.article = article
        guard let imageUrl = article.urlToImage else {
            self.articleImage.value = UIImage(named: Constants.imagePlaseholderName)
            return
        }
        NetworkManager.shared.downloadImage(withUrl: imageUrl) { [weak self] (image) in
            self?.articleImage.value = image
        }
    }
}

extension NewsListCellViewModel: NewsListCellViewModelType {
    var articleTitle: String {
        guard let articleTitle = article.title else { return "" }
        return articleTitle
    }
    var articleSource: String {
        guard let articleSource = article.source.name else { return "" }
        return articleSource
    }
    var articlePublished: String {
        guard let articlePublished = article.publishedAt else { return "" }
        return articlePublished
    }
    
    var articleWatched: Bool {
        guard let watcheMark = article.watched else { return false }
        return watcheMark
    }
}

extension NewsListCellViewModel {
    private struct Constants {
        static let imagePlaseholderName = "ImagePlaseholder"
    }
}
