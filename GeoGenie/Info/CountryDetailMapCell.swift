//
//  CountryDetailMapCell.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/30/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountryDetailMapCell: UITableViewCell {
    @IBOutlet weak var regularKeyLabel: UILabel!
    
    func configureCell(keyName: String, valueName: String) {
        regularKeyLabel.text = keyName
    }
}
