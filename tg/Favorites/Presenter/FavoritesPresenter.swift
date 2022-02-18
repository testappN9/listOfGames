//
//  Presenter.swift
//  tg
//
//  Created by Apple on 13.02.22.
//

import Foundation
import CoreData

class FavoritesPresenter: FavoritesViewDelegate {
    weak var view: FavoritesPresenterDelegate?
    var arrayOfAddedGames: [GamesCollection] = []
    let screenTitle = "Favorites"
    
    required init(view: FavoritesPresenterDelegate) {
        self.view = view
    }
    
    func reloadListOfGames() {
        arrayOfAddedGames = CoreDataManager.dataManager.receiveData() ?? []
    }
    
    func tableNumberOfRows() -> Int {
        return arrayOfAddedGames.count
    }
    
    func tableCellData(indexPath: Int) -> CellData? {
        let games = arrayOfAddedGames
        let gameForCell = games[indexPath]
        return CellData(game: gameForCell)
    }
    
    func tableDeleteCell(id: Int) -> Int {
        for (index, value) in arrayOfAddedGames.enumerated() where value.id == id {
            arrayOfAddedGames.remove(at: index)
            CoreDataManager.dataManager.deleteItem(id: id)
            return index
        }
        return 0
    }
}
