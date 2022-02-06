//
//  FavoritesViewController.swift
//  tg
//
//  Created by Apple on 1.02.22.
//

import Foundation
import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableFavorites: UITableView!
    var arrayOfAddedGames: [GamesCollection]?
    
    override func viewWillAppear(_ animated: Bool) {
        arrayOfAddedGames = CoreDataManager.dataManager.receiveData()
        tableFavorites.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        registerTableFavorites()
    }
    func registerTableFavorites() {
        tableFavorites.delegate = self
        tableFavorites.dataSource = self
        tableFavorites.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "cellFavoritesTableListOfGame")
        tableFavorites.separatorColor = .clear
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAddedGames?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableFavorites.dequeueReusableCell(withIdentifier: "cellFavoritesTableListOfGame", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        if let objects = arrayOfAddedGames {
            if let data = objects[indexPath.row].image {
                cell.logo.image = UIImage(data: data as Data)
            }
            cell.name.text = objects[indexPath.row].name
            cell.id = Int(objects[indexPath.row].id)
        }
        cell.delegate = self
        return cell
    }
}

extension FavoritesViewController: TableListFavoritesOfGameCellDelegate {
    func alertDelete(_ id: Int) {
        let alert = UIAlertController(title: "Delete this game?", message: nil, preferredStyle: .alert)
        let actionOkey = UIAlertAction(title: "Okey", style: .default) { ACTION in
            CoreDataManager.dataManager.deleteItem(id: id)
            self.arrayOfAddedGames = CoreDataManager.dataManager.receiveData()
            self.tableFavorites.reloadData()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionOkey)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}
