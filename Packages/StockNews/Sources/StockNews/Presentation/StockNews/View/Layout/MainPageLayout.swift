//
//  MainPageLayout.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core

enum Section: Int, CaseIterable {
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

            let inset: CGFloat = 2
            let contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            let layoutSection: NSCollectionLayoutSection
            switch section {
            case .stock:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 4), heightDimension: .fractionalHeight(1))
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = contentInsets
                let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize, subitems: [item])

                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .continuous
            case .photoNews:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1))
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 5))
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = contentInsets
                let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize, subitems: [item])

                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .groupPaging

            case .textNews:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.top = 8
                let group: NSCollectionLayoutGroup = .vertical(layoutSize: groupSize, subitems: [item])

                layoutSection = NSCollectionLayoutSection(group: group)
                layoutSection.orthogonalScrollingBehavior = .none
            }

            layoutSection.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)),
                      elementKind: SectionHeaderView.identifierForReuse,
                      alignment: .topLeading)
            ]

            return layoutSection
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
