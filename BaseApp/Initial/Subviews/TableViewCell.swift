//
//  TableViewCell.swift
//  BaseApp
//
//  Created by Erkan Ugurlu on 13.03.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {

    var model: Todo? {
        didSet {
            updateCell(with: model)
        }
    }

    func updateCell(with model: Todo?) {
        textLabel?.text = model?.title
    }
}
