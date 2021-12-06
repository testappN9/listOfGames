//
//  SingletonForNetwork.swift
//  tg
//
//  Created by Apple on 9.11.21.
//

import Foundation

class NetworkManager {

    static let networkManager: NetworkManager = NetworkManager()

    func getDataFromServer(_ link: URL, complitionHandler: @escaping (GamesModel) -> Void) {

        let session = URLSession.shared.dataTask(with: link) { (data, _, error) in
            do {
    //                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                guard let data = data else { return }
                let product: GamesModel = try JSONDecoder().decode(GamesModel.self, from: data)
                complitionHandler(product)
            } catch {
                print(error)
               }

        }
        session.resume()
    }
}
