//
//  NewsListCellViewModelType.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit

protocol NewsListCellViewModelType: class {
    var articleImage: BindableType<UIImage?> { get }
    var articleTitle: String { get }
    var articleSource: String { get }
    var articlePublished: String { get }
    var articleWatched: Bool { get }
}
