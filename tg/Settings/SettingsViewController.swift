//
//  SettingsViewController.swift
//  tg
//
//  Created by Apple on 13.12.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableSettings: UITableView!
    @IBOutlet weak var userPhoto: UIView!
    let arrayOfNames = ["View", "Theme", "Background"]
    let arrayOfAllStates = [("table", "icons"), ("light", "dark"), ("white", "gray")]
    var arrayOfCurrentStates = [UserDefaults.standard.integer(forKey: "viewState"), UserDefaults.standard.integer(forKey: "themeState"), UserDefaults.standard.integer(forKey: "backgroundState")]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableSettings()
        userPhoto.layer.cornerRadius = 15
        UserSettingsRegistration.apply(currentClass: self, table: tableSettings, collection: nil, searchController: nil, tableForHide: nil)
    }
    func registerTableSettings() {
        tableSettings.delegate = self
        tableSettings.dataSource = self
        tableSettings.register(UINib(nibName: "TableSettingsCell", bundle: nil), forCellReuseIdentifier: "TableSettingsCell")
        tableSettings.separatorColor = .clear
        tableSettings.allowsSelection = false
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCurrentStates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSettings.dequeueReusableCell(withIdentifier: "TableSettingsCell", for: indexPath) as! TableSettingsCell
        cell.name.text = arrayOfNames[indexPath.row]
        cell.segmentedControl.setTitle(arrayOfAllStates[indexPath.row].0, forSegmentAt: 0)
        cell.segmentedControl.setTitle(arrayOfAllStates[indexPath.row].1, forSegmentAt: 1)
        cell.segmentedControl.selectedSegmentIndex = arrayOfCurrentStates[indexPath.row]
        cell.indexPathRow = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension SettingsViewController: TableSettingsCellDelegate {
    func changeOption(_ indexPathRow: Int , _ selectedIndex: Int) {
        func saveToUserDefaults (_ key: String) {
            UserDefaults.standard.setValue(selectedIndex, forKey: key)
        }
        switch indexPathRow {
        case 0:
            saveToUserDefaults("viewState")
        case 1:
            saveToUserDefaults("themeState")
        case 2:
            saveToUserDefaults("backgroundState")
        default:
            break
        }
        UserSettingsRegistration.apply(currentClass: self, table: tableSettings, collection: nil, searchController: nil, tableForHide: nil)
    }
}
