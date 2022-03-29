//
//  UIViewController.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import UIKit

public extension UIViewController {

    func displayAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
