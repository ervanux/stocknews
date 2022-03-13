//
//  Observable.swift
//  
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation

public class Observable<T> {
    private var listener: [((T?) -> Void)] = []
    public var value: T? {
        didSet {
            listener.forEach {
                $0(value)
            }
        }
    }

    public init(_ value: T?) {
        self.value = value
    }

    public func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener.append(listener)
    }
}
