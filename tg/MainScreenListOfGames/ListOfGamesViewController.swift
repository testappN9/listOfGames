//
//  ViewController.swift
//  tg
//
//  Created by Apple on 1.11.21.
//

import UIKit
import CoreData

class ListOfGamesViewController: UIViewController {
    
    @IBOutlet weak var collectionListOfGames: UICollectionView!
    @IBOutlet weak var tableListOfGame: UITableView!
    @IBOutlet weak var containerForSearchBar: UIView!
    var gameList: [Game] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.loadLogoOfGames()
                self?.resultsOfSearch = self?.gameList ?? []
//                self.listOfGames.reloadData()
                self?.tableListOfGame.reloadData()
                self?.animatedСircle.isHidden = true
                self?.animatedСircle.animationStop()
                self?.collectionListOfGames.reloadData()
            }
        }
    }
    let animatedСircle = LoadingAnimation()
    let searchController = UISearchController(searchResultsController: nil)
    var resultsOfSearch = [Game]()
    var dictionaryOfLogo = [Int: UIImage]()
    var arrayOfAddedGames = [Int]()

    struct Properties {
        static let cellName = "ListOfGamesViewCell"
        static let linkForData = "https://api.rawg.io/api/games?key=1f1e96182ddd49dab48e0f16889a1aae"
        static let minimumInteritemSpacingForSection: CGFloat = 10
        static let minimumLineSpacingForSection: CGFloat = 10
        static let widthForCellСoefficient: CGFloat = 2
        static let heightForCellСoefficient: CGFloat = 3.5
        static let borderForCell: CGFloat = 10
        static let sizeOfLoadCircle: CGFloat = 50
    }

    override func viewDidAppear(_ animated: Bool) {
        if animatedСircle.isHidden == false {
            animatedСircle.animationResume()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        UserSettingsRegistration.apply(currentClass: self, table: tableListOfGame, collection: collectionListOfGames, searchController: searchController, tableForHide: tableListOfGame)
        checkingAddedGames()
        tableListOfGame.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of games"
        tableListOfGame.allowsSelection = false
        searchControllerSettings()
        receiveDataFromServer()
        registerListOfGame()
        registerTableListOfGame()
        loadingAnimation()
    }
    func checkingAddedGames() {
        guard let dataApproved = CoreDataManager.dataManager.receiveData() else { return }
        arrayOfAddedGames = []
        for item in dataApproved {
            arrayOfAddedGames.append(Int(item.id))
        }
    }
    func searchControllerSettings() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        containerForSearchBar.addSubview(searchController.searchBar)
        definesPresentationContext = true
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

    func receiveDataFromServer() {
        guard let url = URL(string: Properties.linkForData) else {return}
        NetworkManager.networkManager.getDataFromServer(url, complitionHandler: { data in
                self.gameList = data.results ?? []
        })
    }
    func loadLogoOfGames() {
        for item in gameList {
            var readyImage = UIImage(named: "dice")
            if let backImage = item.backgroundImage {
                if let data = NSData(contentsOf: NSURL(string: backImage)! as URL) {
                    readyImage = UIImage(data: data as Data)
                }
            }
            dictionaryOfLogo[item.id] = readyImage
        }
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
}

extension ListOfGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsOfSearch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableListOfGame.dequeueReusableCell(withIdentifier: "cellTableListOfGame", for: indexPath) as? TableListOfGameCell else { return UITableViewCell() }
        let id = resultsOfSearch[indexPath.row].id
        var colorOfAdd = UIColor.red
        for item in arrayOfAddedGames {
            if item == id {
                colorOfAdd = .gray
            }
        }
        let image = dictionaryOfLogo[id]
        cell.config(game: resultsOfSearch[indexPath.row], logoOfGame: image, colorOfAdd: colorOfAdd)
        cell.delegate = self
        return cell
    }
}
extension ListOfGamesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            resultsOfSearch = gameList
            tableListOfGame.reloadData()
            collectionListOfGames.reloadData()
            return
        }
        filtration(text)
    }
    func filtration(_ text: String) {
        resultsOfSearch = gameList.filter({ (game: Game) in
            return game.name?.lowercased().contains(text.lowercased()) ?? false
        })
        tableListOfGame.reloadData()
        collectionListOfGames.reloadData()
    }
}

extension ListOfGamesViewController: TableListOfGameCellDelegate {
    func openGameDetails(_ game: Game) {
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        if let vcAboutApp = mainStory.instantiateViewController(identifier: "aboutApp") as? AboutGameViewController {
            vcAboutApp.game = game
            navigationController?.pushViewController(vcAboutApp, animated: true)
        }
    }
    func stateOfAdd(_ id: Int, _ state: Bool) {
        if state == true {
            arrayOfAddedGames.append(id)
        }
        else {
            if let index = arrayOfAddedGames.firstIndex(of: id) {
                arrayOfAddedGames.remove(at: index)
            }
        }
    }
}

extension ListOfGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsOfSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.cellName, for: indexPath) as! ListOfGamesViewCell
        let id = resultsOfSearch[indexPath.row].id
        let image = dictionaryOfLogo[id]
        cell.config(game: gameList[indexPath.row], logoOfGame: image)
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
            vcAboutApp.game = resultsOfSearch[indexPath.row]
            navigationController?.pushViewController(vcAboutApp, animated: true)
        }
    }
}
 
