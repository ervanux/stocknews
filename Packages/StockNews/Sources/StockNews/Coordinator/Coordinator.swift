//
//  Coordinator.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation
import UIKit
import Network
import Core

public class Coordinator {
    static let shared = Coordinator()

    private init() {
        // To prevent creating another instance. it is singleton
    }

    private lazy var network: NetworkProvidable = {
        NetworkProvider()
    }()

    private lazy var respository: Repository = {
        Repository(network: network)
    }()
}

extension Coordinator: EntryPointProvider {
    public static func start() -> UIViewController {
        StockNewsViewController(repository: shared.respository)
    }
}
