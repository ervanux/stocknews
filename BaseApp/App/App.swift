//
//  Coordinator.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation
import UIKit
import Network

class App {
    lazy var network: NetworkProvidable = {
        NetworkProvider()
    }()

    lazy var respository: Repository = {
        Repository(network: network)
    }()
}

extension App {
    func firstScreen() -> UIViewController {
        InitialViewController(fetchable: respository)
    }
}
