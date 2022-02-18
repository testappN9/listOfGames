//
//  File.swift
//  tg
//
//  Created by Apple on 13.02.22.
//

import Foundation

struct CellData {
    var id: Int?
    var name: String?
    var image: Data?
    
    init(game: GamesCollection) {
        id = Int(game.id)
        name = game.name
        image = game.image
    }
}
