//
//  Game.swift
//  tg
//
//  Created by Apple on 3.11.21.
//

import Foundation

struct FromServer: Codable {
    var count: Int?
    var results: [Game]?
    var description: String?
}

struct Game: Codable, Equatable {
    var id: Int?
    var name: String?
    var rating: Float?
    var backgroundImage: String?
    var released: String?
    var image: String?
    var width: Float?
    var height: Float?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case backgroundImage = "background_image"
        case released
        case image
        case width
        case height
    }


     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
        self.rating = try? container.decodeIfPresent(Float.self, forKey: .rating)
        self.backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        self.released = try? container.decode(String.self, forKey: .released)
        self.image = try? container.decode(String.self, forKey: .image)
        self.width = try? container.decodeIfPresent(Float.self, forKey: .width)
        self.height = try? container.decodeIfPresent(Float.self, forKey: .height)
        
    }
}


extension FromServer {
    
    func gameDescription() -> String {
        
        guard let description = description else { return "no description" }
        
        return description.replacingOccurrences(of: "<p>", with: "   ").replacingOccurrences(of: "</p>", with: "   ").replacingOccurrences(of: "<br />", with: "   ")
    }
}





