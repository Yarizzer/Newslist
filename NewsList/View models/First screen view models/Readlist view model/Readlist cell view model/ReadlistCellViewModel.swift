//
//  ReadlistCellViewModel.swift
//  NewsList
//
//  Created by Yarr!zzeR on 31/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit

class ReadlistCellViewModel {
    var article: ArticleDBItem
    init(forArticle article: ArticleDBItem) {
        self.article = article
    }
}

extension ReadlistCellViewModel: ReadlistCellViewModelType {
    var articleTitle: String {
        return article.articleTitle
    }
    
    var appendMoment: String {
        guard let moment = article.registerMoment as Date? else { return "No data" }
        
        let timeZoneIdentifier = TimeZone.current.identifier
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        dateFormatter.dateStyle = .medium
        //        dateFormatter.timeStyle = .medium
        
        return "Due date: \(dateFormatter.string(from: moment))"
    }
    
    var articleImage: UIImage? {
        guard let imageData = article.articleImage as Data? else { return nil }
        return UIImage(data: imageData)
    }
}
