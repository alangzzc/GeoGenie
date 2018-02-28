//
//  SettingsVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/28/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, SJFluidSegmentedControlDataSource {
    let possibleAnswers = ["5","10","15","20","25","K"]
    let integerAnswers = [5,10,15,20,25,1000]
    
    //var checkmark: CheckmarkSegmentedControl = CheckmarkSegmentedControl(frame:  CGRect(x: 16, y: 444, width: 288, height: 66))
    //let backgroundColor = UIColor(red: 0, green: 84 / 256, blue: 147 / 256, alpha: 0.9)
    
    @IBOutlet weak var numberOfQuestions: SJFluidSegmentedControl!
    @IBOutlet weak var backButton: DynamicButton!
    @IBOutlet weak var babyModeSwitch: UISwitch!
    
    @IBAction func backButtonPressed(_ sender: DynamicButton) {
        
        // Update settings with users selections
        babyMode = babyModeSwitch.isOn
        totalNumberOfQuestions = integerAnswers[numberOfQuestions.currentSegment]
        
        UserDefaults.standard.set(totalNumberOfQuestions, forKey: "totalNumberOfQuestions")
        UserDefaults.standard.set(babyMode, forKey: "babyMode")
        
        //dismiss View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETTINGS
        let numbOfQuestions = UserDefaults.standard.object(forKey: "totalNumberOfQuestions")
        let babyModeSettings  = UserDefaults.standard.object(forKey: "babyMode")
        
        if let tempNumberOfQuestions = numbOfQuestions as? Int {
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
        
        numberOfQuestions.dataSource = self
        numberOfQuestions.shapeStyle = .roundedRect//liquid
        numberOfQuestions.textFont = .systemFont(ofSize: 20)
        numberOfQuestions.textColor = UIColor.white
        numberOfQuestions.currentSegment = totalNumberOfQuestions <= 25 ? (totalNumberOfQuestions / 5) - 1 : 5
        
        babyModeSwitch.isOn = babyMode
        /*
        checkmark.options = [
            CheckmarkOption(title:"5", borderColor: backgroundColor, fillColor: UIColor.white),
            CheckmarkOption(title: "10", borderColor: backgroundColor, fillColor: UIColor.white),
            CheckmarkOption(title: "15", borderColor: backgroundColor, fillColor: UIColor.white),
            CheckmarkOption(title: "20", borderColor: backgroundColor, fillColor: UIColor.white),
            CheckmarkOption(title: "25", borderColor: backgroundColor, fillColor: UIColor.white),
            CheckmarkOption(title: "∞", borderColor: backgroundColor, fillColor: UIColor.white) //0/84/147
        ]
        checkmark.titleColor = UIColor.white
        checkmark.titleFont = .systemFont(ofSize: 20)
        checkmark.backgroundColor = UIColor.clear
        checkmark.animationLength = 1.5
        view.addSubview(checkmark)
        checkmark.selectedIndex = 1*/
        
        backButton.layer.cornerRadius = 25
        backButton.setStyle(.caretLeft, animated: true)
    }
    
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 6
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
        return possibleAnswers[index]
    }
    
}
