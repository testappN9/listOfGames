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
    @IBOutlet weak var viewForSegmentedControl: UIView!
    @IBOutlet weak var labelForTestCustomView: UILabel!
    var presenter: SettingsViewDelegate!
    var customSegmentedControl: CustomSegmentedControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingsPresenter(view: self)
        registerTableSettings()
        userPhoto.layer.cornerRadius = CGFloat(presenter.photoRadius)
        presenter.applyTheme()
        addingCustomSegmentedControl()
        showPasswordViewController()
    }
    
    func registerTableSettings() {
        tableSettings.delegate = self
        tableSettings.dataSource = self
        tableSettings.register(UINib(nibName: "TableSettingsCell", bundle: nil), forCellReuseIdentifier: "TableSettingsCell")
        tableSettings.separatorColor = .clear
        tableSettings.allowsSelection = false
    }
    
    func addingCustomSegmentedControl() {
        viewForSegmentedControl.layoutIfNeeded()
        customSegmentedControl = CustomSegmentedControl(frame: viewForSegmentedControl.bounds)
        customSegmentedControl?.setSections(labels: ["First!", "Second", "Third", "Fourth"])
        customSegmentedControl?.setFont(size: 20)
        guard let customControl = customSegmentedControl else { return }
        viewForSegmentedControl.addSubview(customControl)
        customSegmentedControl?.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
    }
    
    func showPasswordViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let passwordVC = mainStoryboard.instantiateViewController(identifier: "passwordVC") as? PasswordViewController {
            navigationController?.pushViewController(passwordVC, animated: true)
        }
    }
    
    @objc func handleTap(sender: CustomSegmentedControl.Event) {
        labelForTestCustomView.text = String(customSegmentedControl?.getSelectedIndex() ?? 0)
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
