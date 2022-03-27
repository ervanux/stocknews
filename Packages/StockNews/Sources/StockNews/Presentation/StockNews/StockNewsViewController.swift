//
//  StockNewsViewController.swift
//  
//
//  Created by Erkan Ugurlu on 27.03.2022.
//

import UIKit
import Core

class StockNewsViewController: UIViewController {
    var viewModel: StockNewsViewModel
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MainPageLayout())
        collectionView.backgroundColor = .red
        collectionView.register(NewsBigImageCell.self, forCellWithReuseIdentifier: "NewsBigImageCell") // TODO: ??
        collectionView.register(NewsHorizontalCell.self, forCellWithReuseIdentifier: "NewsHorizontalCell") // TODO: ??
        return collectionView
    }()

    init(repository: Repository) {
        self.viewModel = StockNewsViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.pinToParent(constant: 16)
    }
}

extension StockNewsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Invalid section")
        }

        switch section {
        case .stock:
            return 30
        case .photoNews:
            return Swift.min(viewModel.articles.value?.count ?? 0, 5)
        case .textNews:
            return viewModel.articles.value?[5...].count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }

        switch section {
        case .stock:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "NewsBigImageCell", for: indexPath)
        case .photoNews:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsBigImageCell", for: indexPath) as? NewsBigImageCell else {
                fatalError("Invalid cell type")
            }
            let model = viewModel.articles.value?[indexPath.row]
            cell.model = model
            return cell
        case .textNews:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsHorizontalCell", for: indexPath) as? NewsHorizontalCell else {
                fatalError("Invalid cell type")
            }
            let model = viewModel.articles.value?[indexPath.row + 5]
            cell.model = model
            return cell
        }
    }
}
