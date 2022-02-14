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
    @IBAction func selectorOfState(_ sender: UISegmentedControl) {
        delegate?.changeOption(indexPathRow, sender.selectedSegmentIndex)
    }
}


