//
//  TableListOfGameCell.swift
//  tg
//
//  Created by Apple on 26.11.21.
//

import UIKit

class TableListOfGameCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var buttonDetails: UIButton!
    @IBOutlet weak var mainContainer: UIView!
    var game: Game?
    weak var delegate: TableListOfGameCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
    }

    public func config(game: Game, logoOfGame: UIImage?) {

        self.game = game
        name.text = game.name
        logo.image = logoOfGame
        if let released = game.released {
            year.text = dateFormatter(released)
        }
        guard let rate = game.rating else {return}
        rating.text = "\(rate)"
    }
    func dateFormatter(_ date: String) -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        guard let year = formatterDate.date(from: date) else { return "unknown" }
        formatterDate.dateFormat = "yyyy"
        return formatterDate.string(from: year)
    }
    func cellDesign() {
        mainContainer.layer.cornerRadius = 10
        mainContainer.layer.shadowColor = UIColor.black.cgColor
        mainContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
        mainContainer.layer.shadowOpacity = 0.2
        mainContainer.layer.masksToBounds = false
        logo.layer.cornerRadius = 10
    }
    @IBAction func buttonDetails(_ sender: Any) {
        guard let game = game else { return }
        delegate?.openGameDetails(game)
    }
}

protocol TableListOfGameCellDelegate: AnyObject {
    func openGameDetails(_ game: Game)
}
