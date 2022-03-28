//
//  StockTickerCell.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core
import Combine

class StockTickerCell: UICollectionViewCell {
    private var subscription: AnyCancellable?

    let title: UILabel
    let price: UILabel

    var model: StockPrice? {
        didSet {
            title.text = model?.title
            if let val = model?.price {
                price.text = val.usdString

                if val < 0 {
                    backgroundColor = .red
                } else {
                    backgroundColor = .green
                }
            }
        }
    }

    override init(frame: CGRect) {
        title = UILabel()
        price = UILabel()

        super.init(frame: frame)
        backgroundColor = .white

        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension StockTickerCell {
    func setupSubviews() {
        title.font = .preferredFont(forTextStyle: .subheadline)
        price.font = .preferredFont(forTextStyle: .footnote)

        let labels = UIStackView(arrangedSubviews: [
            title,
            price
        ])

        labels.spacing = 4
        labels.distribution = .equalCentering
        labels.axis = .vertical
        labels.alignment = .center

        contentView.addSubview(labels)
        labels.pinToParent(constant: 8)
    }
}
