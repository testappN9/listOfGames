//
//  ApplyUserSettings.swift
//  tg
//
//  Created by Apple on 20.12.21.
//

import UIKit

class UserSettingsRegistration {
    static func apply(currentClass: AnyObject, table: UITableView?, collection: UICollectionView?, searchController: UISearchController?, tableForHide: UITableView?) {
       
        for name in SettingsItems.allCases {
            let value = UserDefaults.standard.integer(forKey: name.rawValue)
            switch (name.rawValue, value) {
            case (SettingsItems.viewState.rawValue, 0):
                tableForHide?.isHidden = false
            case (SettingsItems.viewState.rawValue, 1):
                tableForHide?.isHidden = true
            case (SettingsItems.themeState.rawValue, 0):
                searchController?.searchBar.barTintColor = .systemGray6
                currentClass.navigationController?.navigationBar.barTintColor = .systemGray6
                currentClass.tabBarController??.tabBar.barTintColor = .systemGray6
            case (SettingsItems.themeState.rawValue, 1):
                searchController?.searchBar.barTintColor = .darkGray
                currentClass.navigationController?.navigationBar.barTintColor = .black
                currentClass.tabBarController?.tabBar.barTintColor = .black
            case (SettingsItems.backgroundState.rawValue, 0):
                currentClass.view?.backgroundColor = .white
                table?.backgroundColor = .white
                collection?.backgroundColor = .white
            case (SettingsItems.backgroundState.rawValue, 1):
                currentClass.view?.backgroundColor = .lightGray
                table?.backgroundColor = .lightGray
                collection?.backgroundColor = .lightGray
            default:
                break
            }
        }
    }
}

enum SettingsItems: String, CaseIterable {
    case viewState
    case themeState
    case backgroundState
}
