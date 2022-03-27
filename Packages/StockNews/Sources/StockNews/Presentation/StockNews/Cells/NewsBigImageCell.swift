//
//  File.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core
import Combine

class NewsBigImageCell: UICollectionViewCell {
    let label: UILabel
    let imageView: UIImageView

    var model: Article? {
        didSet {
            label.text = model?.title
        }
    }

    override init(frame: CGRect) {
        imageView = UIImageView()
        label = UILabel()

        super.init(frame: frame)
        backgroundColor = .white

        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension NewsBigImageCell {
    func setupSubviews() {
        contentView.addSubview(label)

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus")
        contentView.addSubview(imageView)
        imageView.pinToParent()
    }
}

