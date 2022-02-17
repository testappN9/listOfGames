//
//  Protocols.swift
//  tg
//
//  Created by Apple on 14.02.22.
//

import Foundation

protocol SettingsViewDelegate: AnyObject {
    var arrayOfNames: [String] { get }
    var arrayOfAllStates: [(String, String)] { get}
    var arrayOfCurrentStates: [Int] { get set }
    var photoRadius: Int { get }
    init(view: SettingsPresenterDelegate)
    func applyTheme()
    func tableCellData(indexPath: Int) -> SettingsCellData
    func changeOption(_ indexPathRow: Int , _ selectedIndex: Int)
}

protocol SettingsPresenterDelegate: AnyObject {
}

protocol TableSettingsCellDelegate: AnyObject {
    func handlingCellChangingOption(indexPath: Int, selectedIndex: Int)
}
