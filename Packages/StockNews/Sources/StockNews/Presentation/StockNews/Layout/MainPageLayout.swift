//
//  MainPageLayout.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit

enum Section: Int {
    case stock = 0
    case photoNews = 1
    case textNews = 2
}

class MainPageLayout: UICollectionViewCompositionalLayout {

    init() {
        super.init { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Invalid section")
            }

            let inset: CGFloat = 2.5
            let contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            switch section {
            case .stock:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 5), heightDimension: .fractionalHeight(1))
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 12))
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = contentInsets
                let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize, subitems: [item])

                let layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.contentInsets = contentInsets
                layoutSection.orthogonalScrollingBehavior = .continuous
                return layoutSection
            case .photoNews:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1))
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 7))
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = contentInsets
                let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize, subitems: [item])

                let layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.contentInsets = contentInsets
                layoutSection.orthogonalScrollingBehavior = .groupPaging

                layoutSection.visibleItemsInvalidationHandler = { (items, offset, environment) in
                    items.forEach { item in
                        let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                        let minScale: CGFloat = 0.7
                        let maxScale: CGFloat = 1.1
                        let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }

                return layoutSection
            case .textNews:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 8))
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = contentInsets
                let group: NSCollectionLayoutGroup = .vertical(layoutSize: groupSize, subitems: [item])

                let layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.contentInsets = contentInsets
                layoutSection.orthogonalScrollingBehavior = .none
                return layoutSection
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
