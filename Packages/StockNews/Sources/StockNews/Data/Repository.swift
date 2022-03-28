//
//  Repository.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import Foundation
import Network

class Repository {
    private let network: NetworkProvidable

    init(network: NetworkProvidable) {
        self.network = network
    }
}
