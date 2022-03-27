//
//  MainPageLayout.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit

class MainPageLayout: UICollectionViewCompositionalLayout {

    init() {
        super.init { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let fraction: CGFloat = 1 / 3
            let inset: CGFloat = 2.5

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))

            let group: NSCollectionLayoutGroup
            if sectionIndex == 2 {
                group = .vertical(layoutSize: groupSize, subitems: [item])
            } else {
                group = .horizontal(layoutSize: groupSize, subitems: [item])
            }

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            if sectionIndex == 2 {
                section.orthogonalScrollingBehavior = .none
            } else {
                section.orthogonalScrollingBehavior = .groupPaging
            }

            return section
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
