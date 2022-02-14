//
//  AboutGameProtocols.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

protocol AboutGameViewDelegate: AnyObject {
    var game: Game? { get set }
    var descriptionOfGame: String? { get set }
    var screenshots: [Game] { get set }
    var arrayOfScreenshots: [UIImage] { get set }
    init(view: AboutGamePresenterDelegate)
    func applyTheme()
    func receiveDataFromServer()
    func collectionHeightCalculation(frameWidth: CGFloat) -> CGFloat
    func getNameOfGame() -> String?
    func getImageOfGame() -> UIImage?
    func screenshotForCell(indexPath: Int) -> UIImage? 
}

protocol AboutGamePresenterDelegate: AnyObject {
    func reloadAfterUpdate()
}
