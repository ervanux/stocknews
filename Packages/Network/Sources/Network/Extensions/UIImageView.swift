//
//  UIImageView.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import UIKit
import Combine

public extension UIImageView {
    func loadImage(with url: URL) -> AnyCancellable {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
