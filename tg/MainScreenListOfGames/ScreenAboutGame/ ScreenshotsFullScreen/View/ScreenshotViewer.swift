//
//  ScreenshotViewer.swift
//  tg
//
//  Created by Apple on 15.11.21.
//

import UIKit

class ScreenshotViewer: UIViewController, ScreenshotFullPresenterDelegate {
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var collectionOfScreenshots: UICollectionView!
    var presenter: ScreenshotFullViewDelegate!
    var selectedScreenshot = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = ScreenshotFullPresenter(view: self, activeScreenshot: selectedScreenshot)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollection()
        imageBackground.image = presenter.arrayOfScreenshots[presenter.activeScreenshot]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.applyTheme()
    }
    
    func registerCollection() {
        collectionOfScreenshots.delegate = self
        collectionOfScreenshots.dataSource = self
        collectionOfScreenshots.isPagingEnabled = true
    }
}

extension ScreenshotViewer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.arrayOfScreenshots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionOfScreenshots.dequeueReusableCell(withReuseIdentifier: "screenshotCell", for: indexPath) as! BigScreenshotViewCell
        cell.openImage.image = presenter.imageForCell(indexPath: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionOfScreenshots.frame.size.width, height: collectionOfScreenshots.frame.size.height)
    }
}
