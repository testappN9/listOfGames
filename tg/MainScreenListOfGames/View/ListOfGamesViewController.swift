//
//  ViewController.swift
//  tg
//
//  Created by Apple on 1.11.21.
//

import UIKit
import CoreData

class ListOfGamesViewController: UIViewController, MainScreenPresenterDelegate {
    
    @IBOutlet weak var collectionListOfGames: UICollectionView!
    @IBOutlet weak var tableListOfGame: UITableView!
    @IBOutlet weak var containerForSearchBar: UIView!
    var presenter: MainScreenViewDelegate!
    let animatedСircle = LoadingAnimation()
    let searchController = UISearchController(searchResultsController: nil)
    
    struct Properties {
        static let cellName = "ListOfGamesViewCell"
        static let minimumInteritemSpacingForSection: CGFloat = 10
        static let minimumLineSpacingForSection: CGFloat = 10
        static let widthForCellСoefficient: CGFloat = 2
        static let heightForCellСoefficient: CGFloat = 3.5
        static let borderForCell: CGFloat = 10
        static let sizeOfLoadCircle: CGFloat = 50
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = MainScreenPresenter(view: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        if animatedСircle.isHidden == false {
            animatedСircle.animationResume()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.applyTheme()
        presenter.checkingAddedGames()
        tableListOfGame.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.screenTitle
        tableListOfGame.allowsSelection = false
        searchControllerSettings()
        presenter.receiveDataFromServer()
        registerListOfGame()
        registerTableListOfGame()
        loadingAnimation()
    }
    
    func registerTableListOfGame() {
        tableListOfGame.delegate = self
        tableListOfGame.dataSource = self
        tableListOfGame.register(UINib(nibName: "TableListOfGameCell", bundle: nil), forCellReuseIdentifier: "cellTableListOfGame")
        tableListOfGame.separatorColor = .clear
    }
    
    func registerListOfGame() {
        collectionListOfGames.delegate = self
        collectionListOfGames.dataSource = self
        collectionListOfGames.register(UINib(nibName: Properties.cellName, bundle: nil), forCellWithReuseIdentifier: Properties.cellName)
    }
    
    func reloadAfterUpdate() {
        weak var sw = self
        presenter.loadLogoOfGames()
        sw?.animatedСircle.isHidden = true
        sw?.animatedСircle.animationStop()
        tableListOfGame.reloadData()
        collectionListOfGames.reloadData()
    }
    
    func loadingAnimation() {
        let xPosition = tableListOfGame.bounds.width / 2 - (Properties.sizeOfLoadCircle / 2)
        let yPosition = tableListOfGame.bounds.height / 2 - (Properties.sizeOfLoadCircle / 2)
        animatedСircle.frame = CGRect(x: xPosition, y: yPosition, width: Properties.sizeOfLoadCircle, height: Properties.sizeOfLoadCircle)
        animatedСircle.backgroundColor = .clear
        tableListOfGame.addSubview(animatedСircle)
    }
    
    func searchControllerSettings() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        containerForSearchBar.addSubview(searchController.searchBar)
        definesPresentationContext = true
    }
}

extension ListOfGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.resultsOfSearch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableListOfGame.dequeueReusableCell(withIdentifier: "cellTableListOfGame", for: indexPath) as? TableListOfGameCell else { return UITableViewCell() }
        cell.game = presenter.getGameItem(indexPath: indexPath.row)
        cell.config(game: presenter.fetchCellData(indexPath: indexPath.row))
        cell.delegate = self
        return cell
    }
}
extension ListOfGamesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            presenter.resultsOfSearch = presenter.gameList
            tableListOfGame.reloadData()
            collectionListOfGames.reloadData()
            return
        }
        presenter.filterForSearchResults(text)
        tableListOfGame.reloadData()
        collectionListOfGames.reloadData()
    }
}

extension ListOfGamesViewController: TableListOfGameCellDelegate {
    func openGameDetails(_ game: Game) {
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        if let vcAboutApp = mainStory.instantiateViewController(identifier: "aboutApp") as? AboutGameViewController {
            vcAboutApp.presenter.game = game
            navigationController?.pushViewController(vcAboutApp, animated: true)
        }
    }
    func stateOfAdd(gameApproved: Game, image: UIImage?) -> UIColor {
        return presenter.buttonAdd(gameApproved: gameApproved, gameLogo: image)
    }
}

extension ListOfGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.resultsOfSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.cellName, for: indexPath) as! ListOfGamesViewCell
        cell.config(game: presenter.fetchCellData(indexPath: indexPath.item))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / Properties.widthForCellСoefficient - Properties.borderForCell, height: collectionView.frame.size.width / Properties.heightForCellСoefficient)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Properties.minimumInteritemSpacingForSection
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Properties.minimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        if let vcAboutApp = mainStory.instantiateViewController(identifier: "aboutApp") as? AboutGameViewController {
            vcAboutApp.presenter.game = presenter.getGameItem(indexPath: indexPath.item)
            navigationController?.pushViewController(vcAboutApp, animated: true)
        }
    }
}
 
