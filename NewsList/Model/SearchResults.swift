//
//  SearchResults.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
}
