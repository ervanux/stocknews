//
//  SectionHeaderView.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import UIKit
import Core

class SectionHeaderView: UICollectionReusableView {
    var title: UILabel

    override init(frame: CGRect) {
        title = UILabel()
        super.init(frame: .zero)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        addSubview(title)
        title.font = .preferredFont(forTextStyle: .headline)
        title.pinToParent()
    }
}
