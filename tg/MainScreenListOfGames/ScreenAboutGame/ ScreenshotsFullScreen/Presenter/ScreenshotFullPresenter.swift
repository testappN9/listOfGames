//
//  ScreenshotsFullPresenter.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation
import UIKit

class ScreenshotFullPresenter: ScreenshotFullViewDelegate {
    weak var view: ScreenshotFullPresenterDelegate?
    var arrayOfScreenshots: [UIImage] = []
    var activeScreenshot = 0

    required init(view: ScreenshotFullPresenterDelegate, activeScreenshot: Int) {
        self.view = view
    }
    
    func applyTheme() {
        UserSettingsRegistration.apply(currentClass: view as AnyObject, table: nil, collection: nil, searchController: nil, tableForHide: nil)
    }
    
    func imageForCell(indexPath: Int) -> UIImage? {
        var image: UIImage?
        //activeScreenshot = indexPath
        if indexPath + activeScreenshot < arrayOfScreenshots.count {
            image = arrayOfScreenshots[indexPath + activeScreenshot]
        } else {
            image = arrayOfScreenshots[indexPath + activeScreenshot - arrayOfScreenshots.count]
        }
        return image
    }
}
