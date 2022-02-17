//
//  VCaboutApp.swift
//  tg
//
//  Created by Apple on 3.11.21.
//

import UIKit

class AboutGameViewController: UIViewController, AboutGamePresenterDelegate {
    
    @IBOutlet weak var logoOfGame: UIImageView!
    @IBOutlet weak var textOfLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var collectionScreenshots: UICollectionView!
    @IBOutlet weak var collectionScreenshotsHeight: NSLayoutConstraint!
    var presenter: AboutGameViewDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = AboutGamePresenter(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.receiveDataFromServer()
        registerCollection()
        addingInfoAboutGame()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.applyTheme()
    }
    
    func registerCollection() {
        collectionScreenshots.delegate = self
        collectionScreenshots.dataSource = self
        collectionScreenshots.register(UINib(nibName: "CollectionScreenshotsCell", bundle: nil), forCellWithReuseIdentifier: "CollectionScreenshotsCell")
        logoOfGame.layer.cornerRadius = 10
    }
    
    func reloadAfterUpdate() {
        collectionScreenshotsHeight.constant = presenter.collectionHeightCalculation(frameWidth: view.frame.size.width)
        collectionScreenshots.reloadData()
        textDescription.text = presenter.descriptionOfGame
    }
    
    func addingInfoAboutGame() {
        textOfLabel.text = presenter.getNameOfGame()
        logoOfGame.image = presenter.getImageOfGame()
        imageBackground.image = logoOfGame.image
    }
}

extension AboutGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.screenshots.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let imageHeight = presenter.screenshots[indexPath.item].height, let imageWidth = presenter.screenshots[indexPath.item].width else { return CGSize(width: 0, height: 0) }
        let height = CGFloat(imageHeight / imageWidth) * collectionScreenshots.frame.size.width + 2
        return CGSize(width: collectionScreenshots.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionScreenshots.dequeueReusableCell(withReuseIdentifier: "CollectionScreenshotsCell", for: indexPath) as! CollectionScreenshotsCell
        cell.screenshot.image = presenter.screenshotForCell(indexPath: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        if let screenshotViewer = mainStory.instantiateViewController(identifier: "ScreenshotViewer") as? ScreenshotViewer {
            screenshotViewer.presenter.arrayOfScreenshots = presenter.arrayOfScreenshots
            screenshotViewer.selectedScreenshot = indexPath.item
            screenshotViewer.modalTransitionStyle = .flipHorizontal
            screenshotViewer.modalPresentationStyle = .automatic
            present(screenshotViewer, animated: true, completion: nil)
        }
    }
}
