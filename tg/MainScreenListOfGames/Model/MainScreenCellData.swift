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
    
    init(id: Int, name: String?, colorOfButton: UIColor, image: UIImage?, rating: String?, year: String?) {
        self.id = id
        self.name = name
        self.colorOfButton = colorOfButton
        self.image = image
        self.rating = rating
        self.year = year
    }
}
