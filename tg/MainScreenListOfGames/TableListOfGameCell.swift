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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    public func config(game: Game, logoOfGame: UIImage?) {
        
        name.text = game.name
        
//        if let backImage = game.backgroundImage {
//            if let data = NSData(contentsOf: NSURL(string: backImage)! as URL) {
//                logo.image = UIImage(data: data as Data)
//            }
//        }
        
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
