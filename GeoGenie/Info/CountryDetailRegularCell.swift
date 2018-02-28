//
//  CountryDetailRegularCell.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/20/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountryDetailRegularCell: UITableViewCell {

    @IBOutlet weak var regularKeyLabel: UILabel!
    @IBOutlet weak var regularValueLabel: UILabel!
    
    func configureCell(keyName: String, valueName: String) {
        regularKeyLabel.text   = keyName
        regularValueLabel.text = valueName
    }

}
