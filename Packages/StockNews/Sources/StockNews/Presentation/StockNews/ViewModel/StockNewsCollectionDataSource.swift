//
//  StockNewsCollectionDataSource.swift
//  
//
//  Created by Erkan Ugurlu on 28.03.2022.
//

import UIKit

class StockNewsCollectionDataSource: NSObject, UICollectionViewDataSource {
    let viewModel: StockNewsViewModel

    init(viewModel: StockNewsViewModel) {
        self.viewModel = viewModel
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
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

        switch section {
        case .stock:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockTickerCell.identifierForReuse,
                                                                for: indexPath) as? StockTickerCell else {
                fatalError("Invalid cell type")
            }

            let model = viewModel.prices.value?[indexPath.row]
            viewModel.prices.bind {[weak cell] prices in
                let newModel = prices?.first { $0.title == model?.title }

                DispatchQueue.main.async {
                    cell?.model = newModel
                }
            }

            return cell
        case .photoNews:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsBigImageCell.identifierForReuse,
                                                                for: indexPath) as? NewsBigImageCell else {
                fatalError("Invalid cell type")
            }
            let model = viewModel.articles.value?[indexPath.row]
            cell.model = model
            return cell
        case .textNews:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsHorizontalCell.identifierForReuse,
                                                                for: indexPath) as? NewsHorizontalCell else {
                fatalError("Invalid cell type")
            }
            let model = viewModel.articles.value?[indexPath.row + 6]
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
