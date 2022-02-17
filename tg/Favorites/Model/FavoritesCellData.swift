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
    
    init(id: Int?, name: String?, image: Data?) {
        self.id = id
        self.name = name
        self.image = image
    }
}
