//
//  SingletonForNetwork.swift
//  tg
//
//  Created by Apple on 9.11.21.
//

import Foundation

class NetworkManager {

    static let networkManager: NetworkManager = NetworkManager()

    
    func getDataFromServer(_ link: URL, complitionHandler: @escaping (FromServer) -> Void)  {

        let session = URLSession.shared.dataTask(with: link) { (data, response, error) in
            do {
    //                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let product: FromServer! = try JSONDecoder().decode(FromServer.self, from: data!)
                    
                complitionHandler(product)
            }
               catch {
                    print("ERROR")
               }

        }
        session.resume()
    }
}

