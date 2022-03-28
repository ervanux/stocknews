//
//  NewsBigImageCell.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core
import Combine
import Network

class NewsBigImageCell: UICollectionViewCell {
    private var subscription: AnyCancellable?

    let label: UILabel
    let imageView: UIImageView

    var model: Article? {
        didSet {
            label.text = model?.title
            if let urlString = model?.urlToImage, let url = URL(string: urlString) {
                subscription = imageView.loadImage(with: url) // Move this to a better place. Like prefetch?
            }
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
        imageView.contentMode = .scaleAspectFit
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .caption1)
        let content = UIStackView(arrangedSubviews: [
            label,
            imageView
        ])
        content.axis = .vertical
        content.spacing = 4
        contentView.addSubview(content)
        content.pinToParent(constant: 2)
    }
}
