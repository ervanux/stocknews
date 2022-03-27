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
        return collectionView
    }()

    init(repository: Repository) {
        self.viewModel = StockNewsViewModel(repository: repository)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
}

private extension StockNewsViewController {
    func setupSubviews() {
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.pinToParent()
    }
}

extension StockNewsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsBigImageCell", for: indexPath)
        return cell
    }
}
