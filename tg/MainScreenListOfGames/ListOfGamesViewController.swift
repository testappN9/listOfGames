//
//  ViewController.swift
//  tg
//
//  Created by Apple on 1.11.21.
//

import UIKit

class ListOfGamesViewController: UIViewController {
    
    @IBOutlet weak var listOfGames: UICollectionView!
    @IBOutlet weak var tableListOfGame: UITableView!
    @IBOutlet weak var containerForSearchBar: UIView!
    
    var gameList: [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.loadLogoOfGames()
                self.resultsOfSearch = self.gameList
                //self.listOfGames.reloadData()
                self.tableListOfGame.reloadData()
            }
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var resultsOfSearch = [Game]()
    
    var dictionaryOfLogo = [Int : UIImage]()
    
    struct Properties {
        static let cellName = "ListOfGamesViewCell"
        static let linkForData = "https://api.rawg.io/api/games?key=1f1e96182ddd49dab48e0f16889a1aae"
        static let minimumInteritemSpacingForSection: CGFloat = 10
        static let minimumLineSpacingForSection: CGFloat = 10
        static let widthForCellСoefficient: CGFloat = 2
        static let heightForCellСoefficient: CGFloat = 3.5
        static let borderForCell: CGFloat = 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of games"
        tableListOfGame.allowsSelection = false
        searchControllerSettings()
        receiveDataFromServer()
       // registerListOfGame()
        registerTableListOfGame()
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
    
    
  /*  func registerListOfGame() {
        
        listOfGames.delegate = self
        listOfGames.dataSource = self
        
        listOfGames.register(UINib(nibName: Properties.cellName, bundle: nil), forCellWithReuseIdentifier: Properties.cellName)
    } */
    
    
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
        
    }
}

extension ListOfGamesViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsOfSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableListOfGame.dequeueReusableCell(withIdentifier: "cellTableListOfGame", for: indexPath) as! TableListOfGameCell
        
        let id = resultsOfSearch[indexPath.row].id
        let image = dictionaryOfLogo[id]
        cell.config(game: resultsOfSearch[indexPath.row], logoOfGame: image)
        
        cell.delegate = self
        
        return cell
    }
    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let mainStory = UIStoryboard (name: "Main", bundle: nil)
//        if let vcAboutApp = mainStory.instantiateViewController(identifier: "aboutApp") as? AboutGameViewController {
//
//            vcAboutApp.game = searchIsNotEmpty ? resultsOfSearch[indexPath.row] : gameList[indexPath.row]
//            navigationController?.pushViewController(vcAboutApp, animated: true)
//        }
//    }

}

extension ListOfGamesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            resultsOfSearch = gameList
            tableListOfGame.reloadData()
            return
        }
        filtration(text)
    }
    
    func filtration(_ text: String) {
        
        resultsOfSearch = gameList.filter({ (game: Game) in
            return game.name?.lowercased().contains(text.lowercased()) ?? false
        })
        
        tableListOfGame.reloadData()
    }
}


extension ListOfGamesViewController: TableListOfGameCellDelegate {
    
    func openGameDetails(_ game: Game) {
        let mainStory = UIStoryboard (name: "Main", bundle: nil)
        if let vcAboutApp = mainStory.instantiateViewController(identifier: "aboutApp") as? AboutGameViewController {
            vcAboutApp.game = game
            navigationController?.pushViewController(vcAboutApp, animated: true)
        }
    }
}




/*
extension ListOfGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Properties.cellName, for: indexPath) as! ListOfGamesViewCell
        
        cell.config(game: gameList[indexPath.row])
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
    
        let mainStory = UIStoryboard (name: "Main", bundle: nil)
        if let vcAboutApp = mainStory.instantiateViewController(identifier: "aboutApp") as? AboutGameViewController {
            
            vcAboutApp.game = gameList[indexPath.row]
            
            vcAboutApp.modalTransitionStyle = .flipHorizontal
            vcAboutApp.modalPresentationStyle = .automatic
            present(vcAboutApp, animated: true, completion: nil)
        }
    }
}
 */
