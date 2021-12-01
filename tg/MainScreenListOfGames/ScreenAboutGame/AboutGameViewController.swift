//
//  VCaboutApp.swift
//  tg
//
//  Created by Apple on 3.11.21.
//

import UIKit

class AboutGameViewController: UIViewController {
    
    @IBOutlet weak var logoOfGame: UIImageView!
    @IBOutlet weak var textOfLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var collectionScreenshots: UICollectionView!
    @IBOutlet weak var collectionScreenshotsHeight: NSLayoutConstraint!

    var game: Game?
    var screenshots: [Game] = []{
        didSet {
            DispatchQueue.main.async {
                self.heightOfCollection()
                self.collectionScreenshots.reloadData()
                self.textDescription.text = self.descriptionOfGame
            }
        }
    }
    
    var heightCollectionItem: Float = 0
    var descriptionOfGame: String?
    // uneeded property, description of game is a part of Game model
    var arrayOfScreenshots: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        receiveDataFromServer()
        addingInfoAndCollection()
    }
    
    
    func heightOfCollection() {
        var height: CGFloat = 0
        for el in screenshots {
            if el.height != nil && el.width != nil {
                height += 2 + CGFloat(el.height! / el.width! * Float(view.frame.size.width - 20))
            }
        }
        collectionScreenshotsHeight.constant = height
    }
    
    func addingInfoAndCollection() {
        
        let cornerRadius: CGFloat = 10
        
        if let game = game {
            
            textOfLabel.text = game.name
            
            guard let backImage = game.backgroundImage else { return }
            
            if let data = NSData(contentsOf: NSURL(string: backImage)! as URL) {
                logoOfGame.image = UIImage(data: data as Data)
            }
        }
        
        logoOfGame.layer.cornerRadius = cornerRadius
        
        imageBackground.image = logoOfGame.image
        
        collectionScreenshots.delegate = self
        collectionScreenshots.dataSource = self
        collectionScreenshots.register(UINib(nibName: "CollectionScreenshotsCell", bundle: nil), forCellWithReuseIdentifier: "CollectionScreenshotsCell")
        //constants
        
    }
    
    
    func receiveDataFromServer() {
        
        guard let gameId = game?.id else {return}
        
//        enum links: String {
//            case linkDescription, linkScreenshots
//
//            var link: String {
//                switch self {
//                case .linkDescription: return "https://api.rawg.io/api/games/\(gameId)?key=1f1e96182ddd49dab48e0f16889a1aae"
//                case .linkScreenshots: return "https://api.rawg.io/api/games/\(gameId)/screenshots?key=1f1e96182ddd49dab48e0f16889a1aae"
//                }
//
//            }
//        }
        
        let linkDescription = "https://api.rawg.io/api/games/\(gameId)?key=1f1e96182ddd49dab48e0f16889a1aae"
       
        let linkScreenshots = "https://api.rawg.io/api/games/\(gameId)/screenshots?key=1f1e96182ddd49dab48e0f16889a1aae"
        
        guard let urlDescription = URL(string: linkDescription) else { return}
        guard let urlScreenshots = URL(string: linkScreenshots) else { return}

        
        NetworkManager.networkManager.getDataFromServer(urlDescription, complitionHandler: { data in
            self.descriptionOfGame = data.gameDescription()
        })
        
        NetworkManager.networkManager.getDataFromServer(urlScreenshots, complitionHandler: { data in
            self.screenshots = data.results ?? []
        })
    }
}
    

extension AboutGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let imageHeight = screenshots[indexPath.item].height, let imageWidth = screenshots[indexPath.item].width else { return CGSize(width: 0, height: 0) }
        
        let height = CGFloat(imageHeight / imageWidth) * collectionScreenshots.frame.size.width + 2
        
        return CGSize(width: collectionScreenshots.frame.size.width, height: height)

     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionScreenshots.dequeueReusableCell(withReuseIdentifier: "CollectionScreenshotsCell", for: indexPath) as! CollectionScreenshotsCell
        //avoid force unwrapping
        
        guard let screenshot = screenshots[indexPath.item].image else { return cell }
        
        if let data = NSData(contentsOf: NSURL(string: screenshot)! as URL) {
    
            cell.screenshot.image = UIImage(data: data as Data)
            arrayOfScreenshots.append(cell.screenshot.image!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStory = UIStoryboard (name: "Main", bundle: nil)
        if let screenshotViewer = mainStory.instantiateViewController(identifier: "ScreenshotViewer") as? ScreenshotViewer {
            
            screenshotViewer.arrayOfScreenshots = arrayOfScreenshots
            screenshotViewer.activeScreenshot = indexPath.item
            
            screenshotViewer.modalTransitionStyle = .flipHorizontal
            screenshotViewer.modalPresentationStyle = .automatic
            present(screenshotViewer, animated: true, completion: nil)
        }
    }
}
