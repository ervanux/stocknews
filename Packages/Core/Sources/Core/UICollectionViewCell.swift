//
//  UICollectionViewCell.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit

public extension UICollectionViewCell {
    public static var reuseCellIdentifier: String {
        return String(describing: self)
    }
}
