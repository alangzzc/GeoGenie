//
//  CountryListCell.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/19/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryFlagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(country: Dictionary<String, String>) {
        countryFlagImage.image = UIImage(named: (country["flagImg"])!)
        countryNameLabel.text = country["name"]
    }

}
