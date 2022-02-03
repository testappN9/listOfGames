//
//  FavoritesTableViewCell.swift
//  tg
//
//  Created by Apple on 2.02.22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    weak var delegate: TableListFavoritesOfGameCellDelegate?
    var id: Int?

    @IBAction func deleteFromDatabase(_ sender: Any) {
        guard let realId = id else { return }
        delegate?.alertDelete(realId)
    }
}

protocol TableListFavoritesOfGameCellDelegate: AnyObject {
    func alertDelete(_ id: Int)
}
