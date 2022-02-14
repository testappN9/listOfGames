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
        let data = presenter.tableCellData(indexPath: indexPath.row)
        cell.name.text = data.name
        cell.segmentedControl.setTitle(data.option1, forSegmentAt: 0)
        cell.segmentedControl.setTitle(data.option2, forSegmentAt: 1)
        cell.segmentedControl.selectedSegmentIndex = data.selectedOption
        cell.indexPathRow = indexPath.row
        cell.delegate = presenter as? TableSettingsCellDelegate
        return cell
    }
}
