//
//  ListOfGamesViewCell.swift
//  tg
//
//  Created by Apple on 1.11.21.
//

import UIKit

class ListOfGamesViewCell: UICollectionViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var publ: UILabel!
    @IBOutlet weak var rating: UILabel!
    struct Properties {
        var cornerRadius: CGFloat = 10
        var publTextColor = UIColor.gray
        var ratingTextColor = UIColor.red
    }
    let properties = Properties()
    override func awakeFromNib() {
        super.awakeFromNib()
        logo.layer.cornerRadius = properties.cornerRadius
        publ.textColor = properties.publTextColor
        rating.textColor = properties.ratingTextColor
    }

    public func config(game: MainScreenCellData) {
        name.text = game.name
        logo.image = game.image
        publ.text = game.year
        rating.text = game.rating
    }
}
