//
//  DBMainManager.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

class DBMainManager {
    static let shared = DBMainManager()
    
    private init() {}
    
    func removeRecords(forArticle article: ArticleDBItem) {
        DBReadListManager.shared.removeRecord(forArticle: article)
    }
    
    func addArticleToReadList(forArticle article: Article) {
        DBReadListManager.shared.performARecord(forArticle: article)
    }
    
    func getReadlisItems() -> [ArticleDBItem] {
        return DBReadListManager.shared.getReadlistItems()
    }
}
