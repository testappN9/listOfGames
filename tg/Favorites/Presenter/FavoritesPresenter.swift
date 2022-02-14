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
    var arrayOfAddedGames: [GamesCollection]?
    let screenTitle = "Favorites"
    
    required init(view: FavoritesPresenterDelegate) {
        self.view = view
    }
    
    func reloadListOfGames() {
        arrayOfAddedGames = CoreDataManager.dataManager.receiveData()
    }
    
    func tableNumberOfRows() -> Int {
        return CoreDataManager.dataManager.receiveData()?.count ?? 0
    }
    
    func tableCellData(indexPath: Int) -> CellData? {
        if let objects = arrayOfAddedGames {
            let id = Int(objects[indexPath].id)
            let name = objects[indexPath].name
            let imageData = objects[indexPath].image
            return CellData(id: id, name: name, image: imageData)
        } else {
            return nil
        }
    }
    
    func tableDeleteCell(id: Int) {
        CoreDataManager.dataManager.deleteItem(id: id)
    }
}
