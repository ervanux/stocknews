//
//  StockNewsViewController.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core
import Combine

class StockNewsViewController: UIViewController {
    private let viewModel: StockNewsViewModel
    private let collectionViewDataSource: StockNewsCollectionDataSource
    private var articleSubscription: AnyCancellable?
    private var stockSubscription: AnyCancellable?

    private lazy var collectionView: UICollectionView = {
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
        self.viewModel = StockNewsViewModel(repository: repository)
        self.collectionViewDataSource = StockNewsCollectionDataSource(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "StockNews"
        navigationController?.hidesBarsOnSwipe = true
        setupSubviews()
        subscribeToNews()
        subscribeToStocks()
        viewModel.fetchContent {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.displayAlert(message: errorMessage ?? "Unknown Error") // TODO: Better error handling!
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

private extension StockNewsViewController {

    func subscribeToNews() {
        articleSubscription = viewModel.articles
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.collectionView.reloadData()
            }
    }

    func subscribeToStocks() {
        stockSubscription = viewModel.prices
            .receive(on: DispatchQueue.main)
            .sink {[weak self] prices in
                // BUG: count is same but models are different
                if prices.count != self?.collectionView.numberOfItems(inSection: Section.stock.rawValue) {
                    self?.collectionView.reloadData()
                }
            }
    }
}
