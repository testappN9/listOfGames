//
//  Presenter.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation

class SettingsPresenter: SettingsViewDelegate {
   
    weak var view: SettingsPresenterDelegate?
    
    let arrayOfNames = ["View", "Theme", "Background"]
    let arrayOfAllStates = [("table", "icons"), ("light", "dark"), ("white", "gray")]
    var arrayOfCurrentStates = [UserDefaults.standard.integer(forKey: SettingsItems.viewState.rawValue), UserDefaults.standard.integer(forKey: SettingsItems.themeState.rawValue), UserDefaults.standard.integer(forKey: SettingsItems.backgroundState.rawValue)]
    let photoRadius = 15
    
    required init(view: SettingsPresenterDelegate) {
        self.view = view
    }
    
    func applyTheme() {
        UserSettingsRegistration.apply(currentClass: view as AnyObject, table: (view as AnyObject).tableSettings, collection: nil, searchController: nil, tableForHide: nil)
    }
    
    func tableCellData(indexPath: Int) -> SettingsCellData {
        let name = arrayOfNames[indexPath]
        let option1 = arrayOfAllStates[indexPath].0
        let option2 = arrayOfAllStates[indexPath].1
        let selectedOption = arrayOfCurrentStates[indexPath]
        return SettingsCellData(name: name, option1: option1, option2: option2, selectedOption: selectedOption)
    }
}

extension SettingsPresenter: TableSettingsCellDelegate {
    func changeOption(_ indexPathRow: Int , _ selectedIndex: Int) {
        func saveToUserDefaults (_ key: String) {
            UserDefaults.standard.setValue(selectedIndex, forKey: key)
        }
        switch indexPathRow {
        case 0:
            saveToUserDefaults(SettingsItems.viewState.rawValue)
        case 1:
            saveToUserDefaults(SettingsItems.themeState.rawValue)
        case 2:
            saveToUserDefaults(SettingsItems.backgroundState.rawValue)
        default:
            break
        }
        applyTheme()
    }
}
