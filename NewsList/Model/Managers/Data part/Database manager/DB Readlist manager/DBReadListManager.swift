//
//  DBReadListManager.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit
import CoreData

class DBReadListManager {
    static let shared = DBReadListManager()
    
    private init() {}
    
    private func getContext() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func performARecord(forArticle article: Article) {
        let context = getContext()
        
        let articleItem = NSEntityDescription.entity(forEntityName: "ArticleDBItem", in: context)
        let articleItemObject = NSManagedObject(entity: articleItem!, insertInto: context) as! ArticleDBItem
        articleItemObject.articleTitle = article.title ?? ""
        articleItemObject.articleDescription = article.description ?? ""
        articleItemObject.articleAuthor = article.author ?? ""
        articleItemObject.articlePublishedAt = article.publishedAt ?? ""
        articleItemObject.articleSourceName = article.source.name ?? ""
        articleItemObject.articleUrl = article.url ?? ""
        
        let articleImageUrl = article.urlToImage ?? ""
        NetworkManager.shared.downloadImage(withUrl: articleImageUrl) { (image) in
            let imageData = image?.pngData()
            articleItemObject.articleImage = imageData as NSData?
        }
        articleItemObject.registerMoment = Date() as NSDate
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getReadlistItems() -> [ArticleDBItem] {
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<ArticleDBItem> = ArticleDBItem.fetchRequest()
        
        var arrayToReturn = [ArticleDBItem]()
        do {
            let arrayOfArticlesInDataBase = try context.fetch(fetchRequest)
            arrayToReturn = arrayOfArticlesInDataBase.sorted {$0.registerMoment.timeIntervalSinceNow > $1.registerMoment.timeIntervalSinceNow}
        } catch {
            print(error.localizedDescription)
        }
        
        return arrayToReturn
    }
    
    func removeRecord(forArticle article: ArticleDBItem) {
        let context = getContext()
        let fetchRequest: NSFetchRequest<ArticleDBItem> = ArticleDBItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "SELF = %@", article.objectID)
        do {
            guard let article = try context.fetch(fetchRequest).first else { return }
            context.delete(article)
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
