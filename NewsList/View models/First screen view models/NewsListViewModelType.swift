//
//  NewsListViewModelType.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

protocol NewsListViewModelType {
    var shouldUpdateView: BindableType<Bool?> { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    func setCurrentIndex(withValue value: Int)
    func setWatchedMark()
    func getNewsListCellViewModel(withIndex index: Int) -> NewsListCellViewModelType?
    func getDetailScreenViewModel() -> DetailScreenViewModelType?
    func getReadlistViewModel() -> ReadlistViewModelType?
    func setUserIsSearching(with value: Bool)
    func searchNews(withText text: String)
    
    func addAtricleToReadList(withIndex index: Int)
    
}
