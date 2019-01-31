//
//  ReadlistCellViewModelType.swift
//  NewsList
//
//  Created by Yarr!zzeR on 31/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//
import UIKit

protocol ReadlistCellViewModelType {
    var articleTitle: String { get }
    var appendMoment: String { get }
    var articleImage: UIImage? { get }
}
