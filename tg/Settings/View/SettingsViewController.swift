//
//  SettingsViewController.swift
//  tg
//
//  Created by Apple on 13.12.21.
//

import UIKit

class SettingsViewController: UIViewController, SettingsPresenterDelegate {
    
    @IBOutlet weak var tableSettings: UITableView!
    @IBOutlet weak var userPhoto: UIView!
    var presenter: SettingsViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter(view: self)
        registerTableSettings()
        userPhoto.layer.cornerRadius = CGFloat(presenter.photoRadius)
        presenter.applyTheme()
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
        return presenter.arrayOfCurrentStates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSettings.dequeueReusableCell(withIdentifier: "TableSettingsCell", for: indexPath) as! TableSettingsCell
        cell.indexPathRow = indexPath.row
        cell.delegate = self
        let cellData = presenter.tableCellData(indexPath: indexPath.row)
        cell.cellConfig(data: cellData)
        return cell
    }
}

extension SettingsViewController: TableSettingsCellDelegate {
    func handlingCellChangingOption(indexPath: Int, selectedIndex: Int) {
        presenter.changeOption(indexPath, selectedIndex)
    }
}
