//
//  FavoritesViewController.swift
//  tg
//
//  Created by Apple on 1.02.22.
//

import Foundation
import UIKit
import CoreData

class FavoritesViewController: UIViewController, FavoritesPresenterDelegate {
    @IBOutlet weak var tableFavorites: UITableView!
    var presenter: FavoritesViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        self.title = presenter.screenTitle
        registerTableFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.reloadListOfGames()
        tableFavorites.reloadData()
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
        return presenter.tableNumberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableFavorites.dequeueReusableCell(withIdentifier: "cellFavoritesTableListOfGame", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        if let cellData = presenter.tableCellData(indexPath: indexPath.row) {
            cell.id = cellData.id
            cell.name.text = cellData.name
            if let data = cellData.image {
                cell.logo.image = UIImage(data: data as Data)
            }
        }
        cell.delegate = self
        return cell
    }
}

extension FavoritesViewController: TableListFavoritesOfGameCellDelegate {
    func alertDelete(_ id: Int) {
        let alert = UIAlertController(title: "Delete this game?", message: nil, preferredStyle: .alert)
        let actionOkey = UIAlertAction(title: "Okey", style: .default) { ACTION in
            self.presenter.tableDeleteCell(id: id)
            self.presenter.reloadListOfGames()
            self.tableFavorites.reloadData()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionOkey)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}
