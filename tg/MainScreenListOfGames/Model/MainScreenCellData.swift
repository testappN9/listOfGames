//
//  MainScreenCellData.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

struct MainScreenCellData {
    var id: Int
    var name: String?
    var colorOfButton: UIColor
    var image: UIImage?
    var rating: String?
    var year: String?
    
    init(game: Game, colorOfButton: UIColor, image: UIImage?, year: String?) {
        self.id = game.id
        self.name = game.name
        self.colorOfButton = colorOfButton
        self.image = image
        self.rating = String(game.rating ?? 0)
        self.year = year
    }
}
