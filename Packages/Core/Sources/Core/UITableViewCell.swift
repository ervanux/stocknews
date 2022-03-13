//
//  UITableViewCell.swift
//  
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import UIKit

public extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
