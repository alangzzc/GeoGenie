//
//  CountryDetailImageCell.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/20/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountryDetailImageCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    
    func configureCell(imageName: String) {
        flagImage.image = UIImage(named: imageName)
    }

}
