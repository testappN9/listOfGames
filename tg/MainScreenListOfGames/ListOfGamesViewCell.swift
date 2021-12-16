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

    public func config(game: Game, logoOfGame: UIImage?) {
        name.text = game.name
        logo.image = logoOfGame
        if let released = game.released {
            publ.text = dateFormatter(released)
        }
        if let rate = game.rating {
            rating.text = String(rate)
        }
    }
    func dateFormatter(_ date: String) -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        guard let year = formatterDate.date(from: date) else { return "unknown" }
        formatterDate.dateFormat = "yyyy"
        return formatterDate.string(from: year)
    }
}
