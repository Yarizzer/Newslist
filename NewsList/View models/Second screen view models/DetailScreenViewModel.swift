//
//  DetailScreenViewModel.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit
class DetailScreenViewModel {
    var article: Article?
    var articleImage: BindableType<UIImage?> = BindableType(nil)
    
    var articleFromDB: ArticleDBItem?
    
    init(forArticle article: Article) {
        self.article = article
        self.articleFromDB = nil
        guard let imageUrl = article.urlToImage else {
            self.articleImage.value = UIImage(named: Constants.imagePlaseholderName)
            return
        }
        NetworkManager.shared.downloadImage(withUrl: imageUrl) { [weak self] (image) in
            self?.articleImage.value = image
        }
    }
    
    init(forDBArticle article: ArticleDBItem) {
        self.articleFromDB = article
        self.articleImage.value = UIImage(data: article.articleImage! as Data)
        self.article = nil
    }
}

extension DetailScreenViewModel: DetailScreenViewModelType {
    var articleTitle: String {
        if let article = article {
            guard let title = article.title else { return "" }
            return title
        } else {
            guard let title = articleFromDB?.articleTitle else { return "" }
            return title
        }
        
    }
    var articleDescription: String {
        if let article = article {
            guard let description = article.description else { return "" }
            return description
        } else {
            guard let description = articleFromDB?.articleDescription else { return "" }
            return description
        }
    }
    
    var articlePublished: String {
        
        if let article = article {
            guard let published = article.publishedAt else { return "" }
            return published
        } else {
            guard let published = articleFromDB?.articlePublishedAt else { return "" }
            return published
        }
        
        
    }
    var articleURL: String {

        if let article = article {
            guard let urlString = article.url else { return "" }
            return urlString
        } else {
            guard let urlString = articleFromDB?.articleUrl else { return "" }
            return urlString
        }
    }
}

extension DetailScreenViewModel {
    private struct Constants {
        static let imagePlaseholderName = "ImagePlaseholder"
    }
}
