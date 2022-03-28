//
//  StockNewsViewController.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core

class StockNewsViewController: UIViewController {
    let viewModel: StockNewsViewModel
    let collectionViewDataSource: StockNewsCollectionDataSource

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MainPageLayout())
        collectionView.register(StockTickerCell.self, forCellWithReuseIdentifier: StockTickerCell.identifierForReuse)
        collectionView.register(NewsBigImageCell.self, forCellWithReuseIdentifier: NewsBigImageCell.identifierForReuse)
        collectionView.register(NewsHorizontalCell.self, forCellWithReuseIdentifier: NewsHorizontalCell.identifierForReuse)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: SectionHeaderView.identifierForReuse,
                                withReuseIdentifier: SectionHeaderView.identifierForReuse)
        return collectionView
    }()

    init(repository: Repository) {
        self.viewModel = StockNewsViewModel()
        self.collectionViewDataSource = StockNewsCollectionDataSource(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Finance App"
        navigationController?.hidesBarsOnSwipe = true
        setupSubviews()
        viewModel.articles.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadSections([1, 2])
            }
        }
    }
}

private extension StockNewsViewController {
    func setupSubviews() {
        collectionView.dataSource = collectionViewDataSource
        view.addSubview(collectionView)
        collectionView.pinToParent()
    }
}
