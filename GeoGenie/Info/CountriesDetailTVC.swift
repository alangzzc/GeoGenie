//
//  CountriesDetailTVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/20/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class CountriesDetailTVC: UITableViewController {
    
    var sectionNames = ["", "Main", "Codes", "Location", "Map", "Borders", "Translations"]
    
    var section1Names = ["Area","Population","Capital"]
    var section2Names = ["Domain","Alpha 2 Code","Alpha 3 Code", "Calling Code"]
    var section3Names = ["Region","Subregion","Latitude", "Longitude", "Time Zones"]
    var section4Names = ["Location"]
    //var section5Names = ["neighbours"]
    var section6Names = ["Spanish","French","Chinese","Russian","Japanese","Arabic","German","Italian","Portuguese","Dutch"]
    
    var section1Values = [String]()
    var section2Values = [String]()
    var section3Values = [String]()
    var section4Values = [String]()
    var section6Values = [String]()
    
    var name = String()
    var flagImg = String()
    var webDomains = String()
    var callCodes = String()
    var topLevelDomainArray = [String]()
    var callingCodes = [String]()
    var latlng = [Double]()
    var timeZones = [String]()
    var bordersArray = [String]()
    var translationsDictionary = Dictionary<String, String>()
    
    /*let topLevelDomainArray = countryDictionary["topLevelDomain"]! as? [String]
    let callingCodesArray = countryDictionary["callingCodes"]! as? [String]
    let altSpellingsArray = countryDictionary["altSpellings"]! as? [String]
    let timezonesArray = countryDictionary["timezones"]! as? [String]
    let bordersArray = countryDictionary["borders"]! as? [String]
    let currenciesArray = countryDictionary["currencies"]! as? Array<Dictionary<String, String>> */
    /*let currencyCode = countryDictionary![index]["code"]
    let currencyName = countryDictionary![index]["name"]
    let currencySymbol = countryDictionary![index]["symbol"]*/
    //let languagesArray = countryDictionary["languages"]! as? Array<Dictionary<String, String>>
    /*let languagesName = languagesArray![index]["name"]
    let languagesNativeName = languagesArray![index]["nativeName"]
    let languagesiso639_1 = languagesArray![index]["iso639_1"]
    let languagesiso639_2 = languagesArray![index]["iso639_2"]*/
 
    //let regionalBlocsArray = countryDictionary["regionalBlocs"]! as? Array<Dictionary<String, Any>>

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        //dismiss View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* NAVIGATION TITLE */
        name = (countryDictionary["name"]! as? String)!
        
        /* SECTION 0 */
        flagImg = (countryDictionary["flagImg"]! as? String)!
        
        /* SECTION 1 */
        let area       = countryDictionary["area"] as! Double
        let population = countryDictionary["population"] as! Double
        section1Values.append("\(area.withCommas()) km2")
        section1Values.append("\(population.withCommas())")
        section1Values.append(countryDictionary["capital"]! as! String)
        
        /* SECTION 2 */
        topLevelDomainArray = (countryDictionary["topLevelDomain"]! as? [String])!
        webDomains = ""
        callingCodes = (countryDictionary["callingCodes"]! as? [String])!
        callCodes = ""
        
        for domainIndex in 0..<topLevelDomainArray.count {
            webDomains = webDomains + topLevelDomainArray[domainIndex] + " "
        }
        
        for callIndex in 0..<callingCodes.count {
            callCodes = callCodes + callingCodes[callIndex] + " "
        }
        
        section2Values.append(webDomains)
        section2Values.append((countryDictionary["alpha2Code"]! as? String)!)
        section2Values.append((countryDictionary["alpha3Code"]! as? String)!)
        section2Values.append(callCodes)
        
        /* SECTION 3 */
        latlng = (countryDictionary["latlng"]! as? [Double])!
        timeZones = (countryDictionary["timezones"]! as? [String])!
        
        section3Values.append(countryDictionary["region"]! as! String)
        section3Values.append(countryDictionary["subregion"]! as! String)
        section3Values.append("\(latlng[0])")
        section3Values.append("\(latlng[1])")
        
        for zoneIndex in 0..<timeZones.count {
            section3Values.append(timeZones[zoneIndex])
            if zoneIndex > 0 {
                section3Names.append("")
            }
        }
        
        /* SECTION 4 */
        //MAP
        
        /* SECTION 5 */
        bordersArray = (countryDictionary["borders"]! as? [String])!
        
        /* SECTION 6 */
        translationsDictionary = (countryDictionary["translations"]! as? Dictionary<String, String>)!
        section6Values.append(translationsDictionary["es"]!)
        section6Values.append(translationsDictionary["fr"]!)
        section6Values.append(translationsDictionary["zh"]!)
        section6Values.append(translationsDictionary["ru"]!)
        section6Values.append(translationsDictionary["ja"]!)
        section6Values.append(translationsDictionary["fa"]!)
        section6Values.append(translationsDictionary["de"]!)
        section6Values.append(translationsDictionary["it"]!)
        section6Values.append(translationsDictionary["pt"]!)
        section6Values.append(translationsDictionary["nl"]!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = name // Country name will go here
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowsInSectionToReturn = 0
        
        switch section {
        case 0: // flagiImage
            rowsInSectionToReturn = 1
        case 1: // area / population / capital
            rowsInSectionToReturn = 3
        case 2: // domain / alpha2-3 codes / calling code
            rowsInSectionToReturn = 4
        case 3: // region / subregion / latitude / longitude / time zones
            rowsInSectionToReturn = 4 + timeZones.count
        case 4: // Map
            rowsInSectionToReturn = 1
        case 5: // Borders
            rowsInSectionToReturn = bordersArray.count
        case 6: // Translations
            rowsInSectionToReturn = section6Names.count
        default: // pendign to use demonym / native name / numeric code / currencies / languages / regional blocs / gini / cioc
            rowsInSectionToReturn = 0
        }
        return rowsInSectionToReturn
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {  // flag image
            if let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? CountryDetailImageCell {
                cell.configureCell(imageName: flagImg)
                return cell
            }
        } else if indexPath.section == 1 { // Main
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell", for: indexPath) as? CountryDetailRegularCell {
                cell.configureCell(keyName: section1Names[indexPath.row], valueName: section1Values[indexPath.row])
                return cell
            }
        } else if indexPath.section == 2 { // Codes
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell", for: indexPath) as? CountryDetailRegularCell {
                cell.configureCell(keyName: section2Names[indexPath.row], valueName: section2Values[indexPath.row])
                return cell
            }
        } else if indexPath.section == 3 { // Location
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell", for: indexPath) as? CountryDetailRegularCell {
                cell.configureCell(keyName: section3Names[indexPath.row], valueName: section3Values[indexPath.row])
                return cell
            }
        } else if indexPath.section == 4 { // Map
            if let cell = tableView.dequeueReusableCell(withIdentifier: "disclosureCell", for: indexPath) as? CountryDetailMapCell {
                cell.configureCell(keyName: section4Names[indexPath.row], valueName: "")
                return cell
            }
        } else if indexPath.section == 5 { // borders
            if let cell = tableView.dequeueReusableCell(withIdentifier: "bordersCell", for: indexPath) as? CountryDetailBordersCell {
                cell.configureCell(alpha3Code: bordersArray[indexPath.row])
                return cell
            }
        } else if indexPath.section == 6 { //
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell", for: indexPath) as? CountryDetailRegularCell {
                cell.configureCell(keyName: section6Names[indexPath.row], valueName: section6Values[indexPath.row])
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell", for: indexPath) as? CountryDetailRegularCell {
                cell.configureCell(keyName: "yes".capitalized, valueName: "No")
                return cell
            }
        }

        return CountryDetailImageCell() // empty cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        return 25
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 160
        }
        return 50
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
