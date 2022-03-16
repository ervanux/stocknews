//
//  EntryPointProvider.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit

public protocol EntryPointProvider {
    static func start() -> UIViewController
}
