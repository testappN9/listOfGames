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

    public func config(game: Game) {
        name.text = game.name
        if let backImage = game.backgroundImage {
            if let data = NSData(contentsOf: NSURL(string: backImage)! as URL) {
                logo.image = UIImage(data: data as Data)
            }
        }
        guard let released = game.released, let rate = game.rating else {return}
        rating.text = String(rate)
        publ.text = dateFormatter(released)
    }
    func dateFormatter(_ date: String) -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        guard let year = formatterDate.date(from: date) else { return "unknown" }
        formatterDate.dateFormat = "yyyy"
        return formatterDate.string(from: year)
    }
}
