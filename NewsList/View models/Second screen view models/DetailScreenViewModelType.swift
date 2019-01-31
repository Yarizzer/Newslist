//
//  DetailScreenViewModelType.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit
protocol DetailScreenViewModelType {
    var articleTitle: String { get }
    var articleDescription: String { get }
    var articlePublished: String { get }
    var articleURL: String { get }
    var articleImage: BindableType<UIImage?> { get }
}
