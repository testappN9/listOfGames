//
//  TableListOfGameCell.swift
//  tg
//
//  Created by Apple on 26.11.21.
//

import UIKit

class TableListOfGameCell: UITableViewCell {
    //here
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var stackViewForBorder: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func config(game: Game, logoOfGame: UIImage?) {
        
        name.text = game.name
        
        logo.image = logoOfGame
        
        guard let released = game.released, let rate = game.rating else {return}
        rating.text = "\(rate)" //String(rate)
        year.text = dateFormatter(released)
    }
    
    
    func dateFormatter(_ date: String) -> String {
        
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        guard let year = formatterDate.date(from: date) else { return "unknown" }
        formatterDate.dateFormat = "yyyy"
        return formatterDate.string(from: year)
    }
    
    
}
