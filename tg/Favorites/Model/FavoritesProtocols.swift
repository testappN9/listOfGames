//
//  Protocols.swift
//  tg
//
//  Created by Apple on 13.02.22.
//

import Foundation

protocol FavoritesViewDelegate: AnyObject {
    var screenTitle: String { get }
    init(view: FavoritesPresenterDelegate)
    func reloadListOfGames()
    func tableNumberOfRows() -> Int
    func tableCellData(indexPath: Int) -> CellData?
    func tableDeleteCell(id: Int)
}
protocol FavoritesPresenterDelegate: AnyObject {
}
