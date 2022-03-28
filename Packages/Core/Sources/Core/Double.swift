//
//  Double.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import Foundation

public extension Double {
    var usdString: String {
        return String(format: "$%.2f", self)
    }
}
