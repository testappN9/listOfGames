//
//  AboutGamePresenter.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

class AboutGamePresenter: AboutGameViewDelegate {
    weak var view: AboutGamePresenterDelegate?
    var game: Game?
    var screenshots: [Game] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadAfterUpdate()
            }
        }
    }
    var descriptionOfGame: String?
    var arrayOfScreenshots: [UIImage] = []

    required init(view: AboutGamePresenterDelegate) {
        self.view = view
    }
    
    func applyTheme() {
        UserSettingsRegistration.apply(currentClass: view as AnyObject, table: nil, collection: nil, searchController: nil, tableForHide: nil)
    }
    
    func receiveDataFromServer() {
        guard let gameId = game?.id else {return}
        
        NetworkManager.networkManager.getDataFromServer(typeOfData: .description, gameId: gameId, complitionHandler: { [weak self] data in
            self?.descriptionOfGame = data.gameDescription()
        })
        NetworkManager.networkManager.getDataFromServer(typeOfData: .screenshots, gameId: gameId, complitionHandler: { [weak self] data in
            self?.screenshots = data.results ?? []
        })
    }
    
    func collectionHeightCalculation(frameWidth: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        for item in screenshots {
            if item.height != nil && item.width != nil {
                height += 2 + CGFloat(item.height! / item.width! * Float(frameWidth - 20))
            }
        }
        return height
    }

    func getNameOfGame() -> String? {
        return game?.name
    }
    
    func getImageOfGame() -> UIImage? {
        if let game = game {
            guard let backImage = game.backgroundImage else { return nil }
            if let data = NSData(contentsOf: NSURL(string: backImage)! as URL) {
                return UIImage(data: data as Data)
            }
        }
        return nil
    }
    
    func screenshotForCell(indexPath: Int) -> UIImage? {
        var image: UIImage?
        guard let screenshot = screenshots[indexPath].image else { return nil }
        if let data = NSData(contentsOf: NSURL(string: screenshot)! as URL) {
            image = UIImage(data: data as Data)
            if image != nil {
                arrayOfScreenshots.append(image!)
            }
        }
        return image
    }
}
