//
//  StockNewsCollectionDataSource.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import UIKit
import Combine

class StockNewsCollectionDataSource: NSObject {
    let viewModel: StockNewsViewModel

    init(viewModel: StockNewsViewModel) {
        self.viewModel = viewModel
    }
}

extension StockNewsCollectionDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Invalid section")
        }

        return viewModel.itemCount(of: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.identifierForCellinSection, for: indexPath)

        switch section {
        case .stock:
            guard let cell = cell as? StockTickerCell else { fatalError("Invalid cell type") }
            makeSubsription(for: cell, at: indexPath.row)
            return cell
        case .photoNews:
            guard  let cell = cell as? NewsBigImageCell else { fatalError("Invalid cell type") }
            let model = viewModel.articles.value[indexPath.row]
            cell.model = model
            return cell
        case .textNews:
            guard let cell = cell as? NewsHorizontalCell else { fatalError("Invalid cell type") }
            let model = viewModel.articles.value[indexPath.row + 6]
            cell.model = model
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: SectionHeaderView.identifierForReuse,
                                                                           for: indexPath) as? SectionHeaderView else {
            fatalError("Invalid header")
        }

        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }

        header.title.text = viewModel.sectionTitle(section: section)

        return header
    }
}

extension StockNewsCollectionDataSource {

    fileprivate func makeSubsription(for cell: StockTickerCell, at index: Int) {
        // TODO: Check this again. Maybe there is a best practice
        cell.priceSubscription = viewModel.prices
            .flatMap({[weak self] prices in
                Just(prices.first { $0.title == self?.viewModel.prices.value[index].title })
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.model, on: cell)
    }
}

private extension Section {

    var identifierForCellinSection: String {
        switch self {
        case .stock:
            return StockTickerCell.identifierForReuse
        case .photoNews:
            return NewsBigImageCell.identifierForReuse
        case .textNews:
            return NewsHorizontalCell.identifierForReuse
        }
    }
}
