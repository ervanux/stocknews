//
//  UIView.swift
//  
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import UIKit

public extension UIView {
    func pinToParent(constant: CGFloat = 0) {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor , constant: -constant),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
        ])
    }

    func pinToCenterOfParent() {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}
