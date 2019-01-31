//
//  BindableType.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

class BindableType<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    var value: T {
        didSet { listener?(value) }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
