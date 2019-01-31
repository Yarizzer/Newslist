//
//  ReadlistViewModelType.swift
//  NewsList
//
//  Created by Yarr!zzeR on 31/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

protocol ReadlistViewModelType {
    var numberOfRows: Int { get }
    func updateArticles()
    func updateCurrentIndex(withIndex index: Int)
    func getReadlistCellViewModel(withIndex index: Int) -> ReadlistCellViewModelType
    func getDetailScreenViewModel() -> DetailScreenViewModelType?
    func removeReadList()
}
