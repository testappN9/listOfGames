//
//  MainScreenProtocols.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

protocol MainScreenViewDelegate: AnyObject {
 //   var arrayOfNames: [String] { get }
    var screenTitle: String { get }
    var resultsOfSearch: [Game] { get set }
    var gameList: [Game] { get set }
    init(view: MainScreenPresenterDelegate)
    func applyTheme()
    func checkingAddedGames()
    func receiveDataFromServer()
    func loadLogoOfGames()
    func fetchCellData(indexPath: Int) -> MainScreenCellData
    func getGameItem(indexPath: Int) -> Game
    func buttonAdd(gameApproved: Game, gameLogo: UIImage?) -> UIColor
    func filterForSearchResults(_ text: String)
}

protocol MainScreenPresenterDelegate: AnyObject {
    func reloadAfterUpdate()
}
