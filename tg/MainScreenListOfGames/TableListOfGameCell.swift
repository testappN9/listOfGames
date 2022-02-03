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
    public func config(game: Game, logoOfGame: UIImage?, colorOfAdd: UIColor) {
        gameLogo = logoOfGame
        self.game = game
        name.text = game.name
        buttonAdd.setTitleColor(colorOfAdd, for: .normal)
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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var data: [GamesCollection]?
        let fetchRequest: NSFetchRequest<GamesCollection> = GamesCollection.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id = \(gameApproved.id)")
        do {
            data = try context.fetch(fetchRequest)
        } catch {
            print("error")
        }
        if data == [] {
            let object = GamesCollection(context: context)
            object.id = Int64(gameApproved.id)
            object.name = gameApproved.name
            object.image = gameLogo?.pngData()
            delegate?.stateOfAdd(gameApproved.id, true)
            buttonAdd.setTitleColor(.gray, for: .normal)
        } else {
            guard let object = data else { return }
            context.delete(object[0])
            delegate?.stateOfAdd(gameApproved.id, false)
            buttonAdd.setTitleColor(.red, for: .normal)
        }
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
}

protocol TableListOfGameCellDelegate: AnyObject {
    func openGameDetails(_ game: Game)
    func stateOfAdd(_ id: Int, _ state: Bool)
}
