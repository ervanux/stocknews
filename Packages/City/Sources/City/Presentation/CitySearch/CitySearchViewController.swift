//
//  CitySearchViewController.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 16.03.2022.
//

import Foundation
import UIKit

final class CitySearchViewController: UIViewController {
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type a city name"
        textField.textAlignment = .center
        return textField
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal) // TODO: move the name
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(tappedToSearch), for: .touchUpInside)
        return button
    }()

    lazy var tempLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let viewModel: CitySearchViewModel

    init(repository: TempratureFetchable) {
        viewModel = CitySearchViewModel(repository: repository)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupSubViews() {
        let stackView = UIStackView(arrangedSubviews: [searchTextField, searchButton, tempLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pinToCenterOfParent()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
        viewModel.model.bind { [weak self] temp in
            guard let result = temp?.main.temp else {
                // TODO: handle nil result
                return
            }

            DispatchQueue.main.async {
                self?.tempLabel.text = "\(result)"
            }
        }
    }
}

// MARK: Actions
extension CitySearchViewController {

    @objc func tappedToSearch() {
        do {
            try viewModel.loadTemp(with: searchTextField.text)
        } catch {
            tempLabel.text = "Invalid city name"
        }
    }
}
