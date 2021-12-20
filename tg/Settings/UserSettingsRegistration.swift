//
//  ApplyUserSettings.swift
//  tg
//
//  Created by Apple on 20.12.21.
//

import UIKit

class UserSettingsRegistration {
    static func apply(currentClass: AnyObject, table: UITableView?, collection: UICollectionView?, searchController: UISearchController?, tableForHide: UITableView?) {
        let nameOfStateArray = ["viewState", "themeState", "backgroundState"]
        for name in nameOfStateArray {
            let value = UserDefaults.standard.integer(forKey: name)
            switch (name, value) {
            case (nameOfStateArray[0], 0):
                tableForHide?.isHidden = false
            case (nameOfStateArray[0], 1):
                tableForHide?.isHidden = true
            case (nameOfStateArray[1], 0):
                searchController?.searchBar.barTintColor = .systemGray6
                currentClass.navigationController?.navigationBar.barTintColor = .systemGray6
                currentClass.tabBarController??.tabBar.barTintColor = .systemGray6
            case (nameOfStateArray[1], 1):
                searchController?.searchBar.barTintColor = .darkGray
                currentClass.navigationController?.navigationBar.barTintColor = .black
                currentClass.tabBarController?.tabBar.barTintColor = .black
            case (nameOfStateArray[2], 0):
                currentClass.view?.backgroundColor = .white
                table?.backgroundColor = .white
                collection?.backgroundColor = .white
            case (nameOfStateArray[2], 1):
                currentClass.view?.backgroundColor = .lightGray
                table?.backgroundColor = .lightGray
                collection?.backgroundColor = .lightGray
            default:
                break
            }
        }
    }
}
