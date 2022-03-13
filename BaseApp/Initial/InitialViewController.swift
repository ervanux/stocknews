//
//  InitialViewController.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import UIKit
import Core

final class InitialViewController: UIViewController {
    private let viewModel: InitialViewModel

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        return tableView
    }()

    init(fetchable: InitialFetchable) {
        viewModel = InitialViewModel(repository: fetchable)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setupSubviews()
        viewModel.loadTodos()
    }
}

extension InitialViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.todos.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell

        if cell == nil {
            cell = TableViewCell()
        }

        cell?.model = viewModel.todos.value?[indexPath.row]

        return cell!
    }
}

extension InitialViewController {

    func setupSubviews() {
        view.backgroundColor = .red

        viewModel.todos.bind({ [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })

        view.addSubview(tableView)
        tableView.pinToParent()
    }
}
