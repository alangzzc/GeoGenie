//
//  ViewController.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/8/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: DynamicButton!
    
    @IBAction func buttonPressed(_ sender: ZFRippleButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // Put your code which should be executed with a delay here
        })
        //sleep(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETTINGS
        let numberOfQuestions = UserDefaults.standard.object(forKey: "totalNumberOfQuestions")
        let babyModeSettings  = UserDefaults.standard.object(forKey: "babyMode")
        
        if let tempNumberOfQuestions = numberOfQuestions as? Int {
            totalNumberOfQuestions = tempNumberOfQuestions
        } else {
            totalNumberOfQuestions = 10
        }
        
        if let tempBabyMode = babyModeSettings as? Bool {
            babyMode = tempBabyMode
        } else {
            babyMode = false
        }
        
        UserDefaults.standard.set(totalNumberOfQuestions, forKey: "totalNumberOfQuestions")
        UserDefaults.standard.set(babyMode, forKey: "babyMode")
        
        settingsButton.layer.cornerRadius = 25
        settingsButton.setStyle(.plus, animated: true)
        
        // FILL simpleCountries
        var miniCountryDict = Dictionary<String,String>()
        
        for countryIndex in 0..<countries!.count {
            let name = countries![countryIndex]["name"]! as? String
            let alpha3Code = countries![countryIndex]["alpha3Code"]! as? String
            let flagImg = countries![countryIndex]["flagImg"]! as? String
            
            
            //let area = countries![countryIndex]["area"]! as? Double
            //let population = countries![countryIndex]["population"]! as? Double
            
            //if area! <= 10.0 && area! > 0.0 {
                //print("Index: \(countryIndex) Area \(area!) Name: \(name!)")
            //}
            /*
            if population! <= 1000000.0 {
                print("Index: \(countryIndex) population\(population!)")
            }*/
            
            /*let regions = countries![countryIndex]["region"]! as? String
            let subregions = countries![countryIndex]["subregion"]! as? String
            print("\(regions!) - \(subregions!)")*/
            
            miniCountryDict["name"] = name
            miniCountryDict["alpha3Code"] = alpha3Code
            miniCountryDict["flagImg"] = flagImg
            miniCountryDict["row"] = "\(countryIndex)"
            
            simpleCountries.append(miniCountryDict)
        }
    }
}
