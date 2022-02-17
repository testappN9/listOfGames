//
//  MainScreenPresenter.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

class MainScreenPresenter: MainScreenViewDelegate {
    weak var view: MainScreenPresenterDelegate?
    var screenTitle = "List of Game"
    var gameList: [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.resultsOfSearch = self.gameList
                self.view?.reloadAfterUpdate()
            }
        }
    }
    var resultsOfSearch = [Game]()
    var dictionaryOfLogo = [Int: UIImage]()
    var arrayOfAddedGames = [Int]()
    
    struct DateFormatModel {
        static let before = "yyyy-MM-dd"
        static let after = "yyyy"
        static let incorrectData = "unknown"
    }

    required init(view: MainScreenPresenterDelegate) {
        self.view = view
    }
    
    func applyTheme() {
        let object = view as AnyObject
        UserSettingsRegistration.apply(currentClass: object, table: object.tableListOfGame, collection: object.collectionListOfGames, searchController: object.searchController, tableForHide: object.tableListOfGame)
    }
    
    func checkingAddedGames() {
        guard let dataApproved = CoreDataManager.dataManager.receiveData() else { return }
        arrayOfAddedGames = []
        for item in dataApproved {
            arrayOfAddedGames.append(Int(item.id))
        }
    }
    
    func receiveDataFromServer() {
        NetworkManager.networkManager.getDataFromServer(typeOfData: .allGames, gameId: nil, complitionHandler: { [weak self] data in
            self?.gameList = data.results ?? []
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
    }
    
    func fetchCellData(indexPath: Int) -> MainScreenCellData {
        let game = resultsOfSearch[indexPath]
        let image = dictionaryOfLogo[game.id]
        var colorOfButton = UIColor.red
        for item in arrayOfAddedGames where item == game.id {
                colorOfButton = .gray
        }
        var year: String?
        if let released = game.released {
            year = dateFormatter(released)
        }
        
        func dateFormatter(_ date: String) -> String {
            let formatterDate = DateFormatter()
            formatterDate.dateFormat = DateFormatModel.before
            guard let year = formatterDate.date(from: date) else { return DateFormatModel.incorrectData }
            formatterDate.dateFormat = DateFormatModel.after
            return formatterDate.string(from: year)
        }
        return MainScreenCellData(game: game, colorOfButton: colorOfButton, image: image, year: year)
    }
    
    func getGameItem(indexPath: Int) -> Game {
        return resultsOfSearch[indexPath]
    }
    
    func buttonAdd(gameApproved: Game, gameLogo: UIImage?) -> UIColor {
        if CoreDataManager.dataManager.receiveItem(gameApproved.id) == nil {
            CoreDataManager.dataManager.saveItem(id: gameApproved.id, name: gameApproved.name, image: gameLogo)
            arrayOfAddedGames.append(gameApproved.id)
            return UIColor.gray
        } else {
            CoreDataManager.dataManager.deleteItem(id: gameApproved.id)
            if let index = arrayOfAddedGames.firstIndex(of: gameApproved.id) {
                arrayOfAddedGames.remove(at: index)
            }
            return UIColor.red
        }
    }
    
    func filterForSearchResults(_ text: String) {
            resultsOfSearch = gameList.filter({ (game: Game) in
                return game.name?.lowercased().contains(text.lowercased()) ?? false
            })
    }
}



