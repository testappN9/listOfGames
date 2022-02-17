//
//  TableSettingsCell.swift
//  tg
//
//  Created by Apple on 13.12.21.
//

import UIKit

class TableSettingsCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    weak var delegate: TableSettingsCellDelegate?
    var indexPathRow = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfig(data: SettingsCellData) {
        name.text = data.name
        segmentedControl.setTitle(data.option1, forSegmentAt: 0)
        segmentedControl.setTitle(data.option2, forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = data.selectedOption
    }
    
    @IBAction func selectorOfState(_ sender: UISegmentedControl) {
        delegate?.handlingCellChangingOption(indexPath: indexPathRow, selectedIndex: sender.selectedSegmentIndex)
    }
}


