//
//  UICollectionReusableView.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit

public extension UICollectionReusableView {
    static var identifierForReuse: String {
        return String(describing: self)
    }
}
