//
//  TableListOfGameCell.swift
//  tg
//
//  Created by Apple on 26.11.21.
//

import UIKit
import CoreData

class TableListOfGameCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var buttonDetails: UIButton!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var buttonAdd: UIButton!
    var game: Game?
    weak var delegate: TableListOfGameCellDelegate?
    var gameLogo: UIImage?
    var colorOfAddReuse = UIColor.red
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
    }
    
    override func prepareForReuse() {
        buttonAdd.setTitleColor(colorOfAddReuse, for: .normal)
    }
    
    public func config(game: MainScreenCellData?) {
        gameLogo = game?.image
        name.text = game?.name
        year.text = game?.year
        logo.image = game?.image
        rating.text = game?.rating
        if let color = game?.colorOfButton {
            buttonAdd.setTitleColor(color, for: .normal)
        }
    }
    
    func cellDesign() {
        mainContainer.backgroundColor = .systemGray6
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
    @IBAction func addToCollection(_ sender: Any) {
        guard let gameApproved = game else { return }
        let color = delegate?.stateOfAdd(gameApproved: gameApproved, image: gameLogo)
        buttonAdd.setTitleColor(color, for: .normal)
    }
}

protocol TableListOfGameCellDelegate: AnyObject {
    func openGameDetails(_ game: Game)
    func stateOfAdd(gameApproved: Game, image: UIImage?) -> UIColor
}
