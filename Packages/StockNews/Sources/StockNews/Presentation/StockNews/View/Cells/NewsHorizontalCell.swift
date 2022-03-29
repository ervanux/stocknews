//
//  NewsHorizontalCell.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core
import Combine

class NewsHorizontalCell: UICollectionViewCell {
    private var subscription: AnyCancellable?

    let title: UILabel
    let body: UILabel
    let imageView: UIImageView
    let date: UILabel

    var model: Article? {
        didSet {
            title.text = model?.title
            body.text = model?.description
            date.text = model?.publishedAt

            if let urlString = model?.urlToImage, let url = URL(string: urlString) {
                subscription = imageView.loadImage(with: url) // Move this to a better place. Like prefetch?
            }
        }
    }

    override init(frame: CGRect) {
        imageView = UIImageView()
        title = UILabel()
        body = UILabel()
        date = UILabel()

        super.init(frame: frame)
        backgroundColor = .lightGray.withAlphaComponent(0.1)

        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension NewsHorizontalCell {
    func setupSubviews() {
        imageView.contentMode = .scaleAspectFit

        title.font = .preferredFont(forTextStyle: .subheadline)
        title.numberOfLines = 2

        body.font = .preferredFont(forTextStyle: .caption2)
        body.numberOfLines = 0

        date.font = .preferredFont(forTextStyle: .caption2)
        date.textAlignment = .right

        let rightStack = UIStackView(arrangedSubviews: [
            body,
            date
        ])
        rightStack.axis = .vertical

        let bottomStack = UIStackView(arrangedSubviews: [
            imageView,
            rightStack
        ])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 12
        bottomStack.distribution = .equalSpacing

        let containerStack = UIStackView(arrangedSubviews: [
            title,
            bottomStack
        ])

        containerStack.axis = .vertical
        containerStack.spacing = 4
        contentView.addSubview(containerStack)

        containerStack.pinToParent(constant: 8)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
}
