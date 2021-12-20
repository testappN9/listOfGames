//
//  ScreenshotViewer.swift
//  tg
//
//  Created by Apple on 15.11.21.
//

import UIKit

class ScreenshotViewer: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var collectionOfScreenshots: UICollectionView!
    var arrayOfScreenshots: [UIImage] = []
    var activeScreenshot = 0
    override func viewWillAppear(_ animated: Bool) {
        UserSettingsRegistration.apply(currentClass: self, table: nil, collection: nil, searchController: nil, tableForHide: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOfScreenshots.delegate = self
        collectionOfScreenshots.dataSource = self
        collectionOfScreenshots.isPagingEnabled = true
        imageBackground.image = arrayOfScreenshots[activeScreenshot]
    }
}

extension ScreenshotViewer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfScreenshots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionOfScreenshots.dequeueReusableCell(withReuseIdentifier: "screenshotCell", for: indexPath) as! BigScreenshotViewCell
        if indexPath.item + activeScreenshot < arrayOfScreenshots.count {
            cell.openImage.image = arrayOfScreenshots[indexPath.item + activeScreenshot]
        } else {
            cell.openImage.image = arrayOfScreenshots[indexPath.item + activeScreenshot - arrayOfScreenshots.count]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionOfScreenshots.frame.size.width, height: collectionOfScreenshots.frame.size.height)
    }
}
