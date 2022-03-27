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
                subscription = imageView.loadImage(with: url) // Dont do this here!
            }
        }
    }

    override init(frame: CGRect) {
        imageView = UIImageView()
        title = UILabel()
        body = UILabel()
        date = UILabel()

        super.init(frame: frame)
        backgroundColor = .white

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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120)
        ])

        title.font = .systemFont(ofSize: 16)
        title.numberOfLines = 2
        title.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        body.font = .systemFont(ofSize: 12)
        body.numberOfLines = 0
        body.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        date.font = .systemFont(ofSize: 8)
        date.textAlignment = .right
        date.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        let rightStackView = UIStackView(arrangedSubviews: [
            title,
            body,
            date
        ])
        rightStackView.axis = .vertical
        rightStackView.spacing = 8
//        rightStackView.distribution = .fill
        let wholeStackView = UIStackView(arrangedSubviews: [
            imageView,
            rightStackView
        ])
        wholeStackView.axis = .horizontal
        wholeStackView.spacing = 12
        wholeStackView.distribution = .fillProportionally
        contentView.addSubview(wholeStackView)
        wholeStackView.pinToParent(constant: 8)
    }
}

private extension UIImageView {
    func loadImage(with url: URL) -> AnyCancellable {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
