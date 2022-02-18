//
//  ScreenshotFullProtocols.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

protocol ScreenshotFullViewDelegate: AnyObject {
    var arrayOfScreenshots: [UIImage] { get set }
    var activeScreenshot: Int { get set }
    init(view: ScreenshotFullPresenterDelegate, activeScreenshot: Int)
    func applyTheme()
    func imageForCell(indexPath: Int) -> UIImage?
}

protocol ScreenshotFullPresenterDelegate: AnyObject {
}


