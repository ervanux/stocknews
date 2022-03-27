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
    private var subscription: AnyCancellable?

    let label: UILabel
    let imageView: UIImageView

    var model: Article? {
        didSet {
            label.text = model?.title
            if let urlString = model?.urlToImage, let url = URL(string: urlString) {
                load(url: url) // Dont do this here!
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
        contentView.addSubview(label)

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus")
        contentView.addSubview(imageView)
        imageView.pinToParent()
    }
}

private extension NewsBigImageCell {
    func load(url: URL) {
        subscription = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: imageView)
    }

    func cancel() {
        subscription?.cancel()
    }
}
