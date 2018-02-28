//
//  QuizListVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/22/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class QuizListVC: UIViewController {
    
    var optionPressed = ["Area","Population","Region","Flag","Capital"]
    var destinationSegue = String()
    
    @IBOutlet weak var backButton: DynamicButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 25
        backButton.setStyle(.caretLeft, animated: true)
    }
    
    @IBAction func backButton(_ sender: DynamicButton) {
        //dismiss View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: ZFRippleButton) {
        //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // Put your code which should be executed with a delay here
        //})
        //sleep(1)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        destinationSegue = identifier
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if destinationSegue == "Area" || destinationSegue == "Population" {
            let destinationController = segue.destination as! QuizAreaPopulationVC
            destinationController.sourceSegue = destinationSegue
        } else if destinationSegue == "Region" || destinationSegue == "Flag"  || destinationSegue == "Capital" {
            let destinationController = segue.destination as! QuizRegionFlagCapitalVC
            destinationController.sourceSegue = destinationSegue
        }
    }

}
