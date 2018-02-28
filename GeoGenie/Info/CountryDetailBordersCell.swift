//
//  CountryDetailBordersCell.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/20/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountryDetailBordersCell: UITableViewCell {

    @IBOutlet weak var borderFlagImage: UIImageView!
    @IBOutlet weak var borderCountryLabel: UILabel!
    
    func configureCell(alpha3Code: String) {
        let searchPredicate = NSPredicate(format: "alpha3Code CONTAINS[C] %@", alpha3Code)
        let array = (simpleCountries as NSArray).filtered(using: searchPredicate)
        let borderDictionary = array[0] as! Dictionary<String, String>
        
        borderCountryLabel.text = borderDictionary["name"]
        borderFlagImage.image = UIImage(named: borderDictionary["flagImg"]!)
    }

}
