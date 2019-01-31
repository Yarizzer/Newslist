//
//  ArticleDBItem+CoreDataProperties.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
//

import Foundation
import CoreData

extension ArticleDBItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleDBItem> {
        return NSFetchRequest<ArticleDBItem>(entityName: "ArticleDBItem")
    }

    @NSManaged public var articleTitle: String
    @NSManaged public var articleDescription: String
    @NSManaged public var articleAuthor: String
    @NSManaged public var articleSourceName: String
    @NSManaged public var articleUrl: String
    @NSManaged public var articlePublishedAt: String
    @NSManaged public var articleImage: NSData?
    @NSManaged public var registerMoment: NSDate
    
    

}
