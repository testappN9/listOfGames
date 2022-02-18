//
//  SingletonForNetwork.swift
//  tg
//
//  Created by Apple on 9.11.21.
//

import Foundation

class NetworkManager {

    static let networkManager: NetworkManager = NetworkManager()
    let currentToken = "?key=1f1e96182ddd49dab48e0f16889a1aae"
    let linkForData = "https://api.rawg.io/api/games"
    let linkDescription = "https://api.rawg.io/api/games/"
    let linkScreenshots = ("https://api.rawg.io/api/games/", "/screenshots")
    
    private func getLinkForData() -> String {
        return linkForData + currentToken
    }
    
    private func getlinkDescription(_ gameId: Int) -> String {
        return linkDescription + String(gameId) + currentToken
    }
    
    private func getlinkScreenshots(_ gameId: Int) -> String {
        return linkScreenshots.0 + String(gameId) + linkScreenshots.1 + currentToken
    }
    
    func getDataFromServer(typeOfData: typeOfDataCases, gameId: Int?, complitionHandler: @escaping (GamesModel) -> Void) {
        var selectedLink = ""
        switch typeOfData {
        case .allGames:
            selectedLink = getLinkForData()
        case .description:
            guard let id = gameId else { return }
            selectedLink = getlinkDescription(id)
        case .screenshots:
            guard let id = gameId else { return }
            selectedLink = getlinkScreenshots(id)
        }
        guard let link = URL(string: selectedLink) else {return}
        let session = URLSession.shared.dataTask(with: link) { (data, _, error) in
            do {
    //                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                guard let data = data else { return }
                let product: GamesModel = try JSONDecoder().decode(GamesModel.self, from: data)
                complitionHandler(product)
            } catch {
                print("connection error")
               }
        }
        session.resume()
    }
}
