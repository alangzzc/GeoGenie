//
//  QuizRegionFlagCapitalVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/22/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class QuizRegionFlagCapitalVC: UIViewController, UICircularProgressRingDelegate {
    
    lazy var progressRing = UICircularProgressRingView(frame: CGRect(x: (screenWidth - 240) / 2, y: (screenHeight - 240) / 2, width: 240, height: 240))
    
    let screenSize = UIScreen.main.bounds
    var screenWidth : CGFloat! { didSet {if screenWidth == nil {screenWidth = 0.0}}}
    var screenHeight : CGFloat! { didSet {if screenHeight == nil {screenHeight = 0.0}}}
    
    var sourceSegue = String()
    var buttonWithTheRightAnswer : Int!  { didSet {if buttonWithTheRightAnswer == nil {buttonWithTheRightAnswer = 0}}}
    var valueOfEveryCorrectAnswer = 0
    
    var currentQuestion = 0
    var score = 0
    var isAnswerRight: Bool = false
    var lastFiveAnswers = [Bool]()
    
    var countryOption1 = Dictionary<String, Any>()
    var countryOption2 = Dictionary<String, Any>()
    var countryOption3 = Dictionary<String, Any>()
    var countryOption4 = Dictionary<String, Any>()
    var countryOption5 = Dictionary<String, Any>()
    
    var countryOption1Index : Int! { didSet {if countryOption1Index == nil {countryOption1Index = 0}}}
    var countryOption2Index : Int! { didSet {if countryOption2Index == nil {countryOption2Index = 0}}}
    var countryOption3Index : Int! { didSet {if countryOption3Index == nil {countryOption3Index = 0}}}
    var countryOption4Index : Int! { didSet {if countryOption4Index == nil {countryOption4Index = 0}}}
    var countryOption5Index : Int! { didSet {if countryOption5Index == nil {countryOption5Index = 0}}}
    
    var option1Value : String! { didSet {if option1Value == nil {option1Value = ""}}}
    var option2Value : String! { didSet {if option2Value == nil {option2Value = ""}}}
    var option3Value : String! { didSet {if option3Value == nil {option3Value = ""}}}
    var option4Value : String! { didSet {if option4Value == nil {option4Value = ""}}}
    var option5Value : String! { didSet {if option5Value == nil {option5Value = ""}}}
    
    let undesiredCapitalIndices = [8,27,30,128,58,77,79,89,116,155,168,179,183,185,187,199,207,212,244]
    let undesiredFlagIndices    = [8,27,30,    58,77,79,89,116,155,168,179,183,185,187,199,207,212,244] // Countries without a flag
    
    let deselectedRight: UIColor = UIColor.green
    let deselectedWrong: UIColor = UIColor.red
    let deselectedBegin: UIColor = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1.0) // default value
    
    var alertTile = String()
    var alertMessage = String()
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var buttonOption1: ZFRippleButton!
    @IBOutlet weak var buttonOption2: ZFRippleButton!
    @IBOutlet weak var buttonOption3: ZFRippleButton!
    @IBOutlet weak var buttonOption4: ZFRippleButton!
    @IBOutlet weak var buttonOption5: ZFRippleButton!
    @IBOutlet weak var star1: DOFavoriteButton!
    @IBOutlet weak var star2: DOFavoriteButton!
    @IBOutlet weak var star3: DOFavoriteButton!
    @IBOutlet weak var star4: DOFavoriteButton!
    @IBOutlet weak var star5: DOFavoriteButton!
    @IBOutlet weak var backButton: DynamicButton!
    @IBOutlet weak var newButton: DynamicButton!
    
    
    @IBAction func backButton(_ sender: UIButton) {
        //dismiss View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newButtonPressed(_ sender: DynamicButton) {
        newGame()
    }
    
    @IBAction func buttonPressed(_ sender: ZFRippleButton) {
        if buttonWithTheRightAnswer == sender.tag {
            isAnswerRight = true
            score += valueOfEveryCorrectAnswer
        } else {
            isAnswerRight = false
        }
        
        if currentQuestion <= 5 {
            if !babyMode || isAnswerRight {
                lastFiveAnswers.append(isAnswerRight)
            }
            
            switch currentQuestion {
            case 1:
                showStar(sender: star1, answerRight: isAnswerRight)
            case 2:
                showStar(sender: star2, answerRight: isAnswerRight)
            case 3:
                showStar(sender: star3, answerRight: isAnswerRight)
            case 4:
                showStar(sender: star4, answerRight: isAnswerRight)
            default:
                showStar(sender: star5, answerRight: isAnswerRight)
            }
            
        } else {
            for answerIndex in 1..<lastFiveAnswers.count {
                if !babyMode || isAnswerRight {
                    lastFiveAnswers[answerIndex - 1] = lastFiveAnswers[answerIndex]
                    
                    switch answerIndex - 1 {
                    case 0:
                        showStar(sender: star1, answerRight: lastFiveAnswers[answerIndex])
                    case 1:
                        showStar(sender: star2, answerRight: lastFiveAnswers[answerIndex])
                    case 2:
                        showStar(sender: star3, answerRight: lastFiveAnswers[answerIndex])
                    case 3:
                        showStar(sender: star4, answerRight: lastFiveAnswers[answerIndex])
                    default:
                        showStar(sender: star5, answerRight: isAnswerRight)
                    }
                }
            }
            showStar(sender: star5, answerRight: isAnswerRight)
            lastFiveAnswers[4] = isAnswerRight
        }
        
        if !babyMode || isAnswerRight {
            if currentQuestion < totalNumberOfQuestions {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    // Put your code which should be executed with a delay here
                    self.beginNewQuestion()})
            } else {
                showGradeProgressRings()
            }
        }
    }
    
    func showStar(sender: DOFavoriteButton, answerRight: Bool, reset: Bool = false) {
        let colorForStar: UIColor
        
        if reset {
            colorForStar = deselectedBegin
        } else if answerRight {
            colorForStar = deselectedRight
        } else {
            colorForStar = deselectedWrong
        }
        
        if currentQuestion <= 5 {
            sender.imageColorOn = colorForStar
            sender.select()
        } else if sender.tag == 15 {
            sender.imageColorOn = colorForStar
            sender.select()
        } else {
            sender.imageColorOff = colorForStar
            sender.deselect()
        }
    }
    
    func showGradeProgressRings() {
        progressRing.alpha = 1.0
        
        progressRing.animationStyle = kCAMediaTimingFunctionLinear
        progressRing.font = UIFont.systemFont(ofSize: 60)
        progressRing.outerRingColor = UIColor.green
        progressRing.maxValue = 100
        progressRing.valueIndicator = "" // default is % as 75%
        
        
        if score >= 60 {
            if score >= 80 {
                progressRing.fontColor = UIColor.green
                progressRing.innerRingColor = UIColor.green
                
                if score == 100 {
                    alertTile = "PERFECT !!"
                } else {
                    alertTile = "Congratulations"
                }
            } else {
                progressRing.fontColor = UIColor.orange
                progressRing.innerRingColor = UIColor.orange
                alertTile = "Good Job"
            }
        } else {
            progressRing.fontColor = UIColor.red
            progressRing.innerRingColor = UIColor.red
            alertTile = "Ooops !!"
        }
        
        alertMessage = "Score: \(score)"
        
        progressRing.isHidden = false
        progressRing.setProgress(value: CGFloat(score), animationDuration: 2.5, completion: nil) // {}
    }
    
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        if score > 0 {
            sleep(1)
            showNewGameAlert()
        }
    }
    
    func resetStars() {
        // show stars like in the beginning
        showStar(sender: star1, answerRight: false, reset: true)
        showStar(sender: star2, answerRight: false, reset: true)
        showStar(sender: star3, answerRight: false, reset: true)
        showStar(sender: star4, answerRight: false, reset: true)
        showStar(sender: star5, answerRight: false, reset: true)
    }
    
    func newGame() {
        resetStars()
        resetQuizValuesToDefault()
        beginNewQuestion()
        
        progressRing.isHidden = true
        progressRing.setProgress(value: CGFloat(1), animationDuration: 0.1, completion: nil)
    }
    
    func showNewGameAlert() {
        let alertGameOver = UIAlertController(title: alertTile, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertGameOver.addAction(UIAlertAction.init(title: "Back", style: UIAlertActionStyle.default, handler: {alertGameOver in self.dismiss(animated: true, completion: nil)}))
        alertGameOver.addAction(UIAlertAction.init(title: "NEW", style: UIAlertActionStyle.default, handler: {alertGameOver in
            self.newGame()}))
        self.present(alertGameOver, animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 25
        backButton.setStyle(.caretLeft, animated: true)
        newButton.layer.cornerRadius = 25
        newButton.setStyle(.reload, animated: true)
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        valueOfEveryCorrectAnswer = 100 / totalNumberOfQuestions
        
        progressRing.delegate = self
        progressRing.alpha = 0.0
        self.view.addSubview(progressRing)
        
        buttonOption1.layer.cornerRadius = buttonOption1.bounds.height * 0.5
        buttonOption2.layer.cornerRadius = buttonOption1.layer.cornerRadius
        buttonOption3.layer.cornerRadius = buttonOption1.layer.cornerRadius
        buttonOption4.layer.cornerRadius = buttonOption1.layer.cornerRadius
        buttonOption5.layer.cornerRadius = buttonOption1.layer.cornerRadius
        
        beginNewQuestion()
    }
    
    func setButtonsTextValues() {
        buttonOption1.setTitle(option1Value, for: UIControlState.normal)
        buttonOption2.setTitle(option2Value, for: UIControlState.normal)
        buttonOption3.setTitle(option3Value, for: UIControlState.normal)
        buttonOption4.setTitle(option4Value, for: UIControlState.normal)
        buttonOption5.setTitle(option5Value, for: UIControlState.normal)
    }
    
    func getAllOptionsValues() {
        if sourceSegue == "Region" {
            option1Value = regions[0]
            option2Value = regions[1]
            option3Value = regions[2]
            option4Value = regions[3]
            option5Value = regions[4]
        } else if sourceSegue == "Flag" {
            option1Value = countryOption1["name"] as! String
            option2Value = countryOption2["name"] as! String
            option3Value = countryOption3["name"] as! String
            option4Value = countryOption4["name"] as! String
            option5Value = countryOption5["name"] as! String
        } else if sourceSegue == "Capital" {
            option1Value = countryOption1["capital"] as! String
            option2Value = countryOption2["capital"] as! String
            option3Value = countryOption3["capital"] as! String
            option4Value = countryOption4["capital"] as! String
            option5Value = countryOption5["capital"] as! String
        }
    }
    
    func resetAllValuesToDefault() {
        option1Value = ""
        option2Value = ""
        option3Value = ""
        option4Value = ""
        option5Value = ""
        countryOption1Index = 0
        countryOption2Index = 0
        countryOption3Index = 0
        countryOption4Index = 0
        countryOption5Index = 0
        countryOption1 = ["" : ""]
        countryOption2 = ["" : ""]
        countryOption3 = ["" : ""]
        countryOption4 = ["" : ""]
        countryOption5 = ["" : ""]
        buttonWithTheRightAnswer = 0
        buttonOption1.rippleColor = deselectedWrong
        buttonOption2.rippleColor = deselectedWrong
        buttonOption3.rippleColor = deselectedWrong
        buttonOption4.rippleColor = deselectedWrong
        buttonOption5.rippleColor = deselectedWrong
    }
    
    func resetQuizValuesToDefault() {
        currentQuestion = 0
        score = 0
        isAnswerRight = false
        lastFiveAnswers = [Bool]()
    }
    
    func assignDictionaries() {
        countryOption1 = countries![countryOption1Index]
        countryOption2 = countries![countryOption2Index]
        countryOption3 = countries![countryOption3Index]
        countryOption4 = countries![countryOption4Index]
        countryOption5 = countries![countryOption5Index]
    }
    
    func pickCorrectAnswer() {
        if sourceSegue == "Region" {
            let correctRegion = countryOption1["region"] as! String!
            
            for regionsIndex in 0..<regions.count {
                if correctRegion == regions[regionsIndex] {
                    buttonWithTheRightAnswer = regionsIndex + 1
                }
            }
        } else {
            buttonWithTheRightAnswer = 5.arc4random + 1
        }
        
        manageButtonRippleColorBasedOnCurrentRightAnswer()
    }
    
    func manageButtonRippleColorBasedOnCurrentRightAnswer() {
        if buttonWithTheRightAnswer == 1 {
           buttonOption1.rippleColor = deselectedRight
        } else if buttonWithTheRightAnswer == 2 {
            buttonOption2.rippleColor = deselectedRight
        } else if buttonWithTheRightAnswer == 3 {
            buttonOption3.rippleColor = deselectedRight
        } else if buttonWithTheRightAnswer == 4 {
            buttonOption4.rippleColor = deselectedRight
        } else if buttonWithTheRightAnswer == 5 {
            buttonOption5.rippleColor = deselectedRight
        }
    }
    
    func beginNewQuestion() {
        currentQuestion += 1
        resetAllValuesToDefault()
        generateRandomIndexesAsNeeded()
        assignDictionaries()
        getAllOptionsValues()
        setButtonsTextValues()
        pickCorrectAnswer()
        showCorrectFlagAndName()
    }
    
    func showCorrectFlagAndName() {
        var correctName : String!
        var correctFlag : String!
        
        if sourceSegue == "Region" {
            correctFlag = countryOption1["flagImg"] as! String!
            correctName = countryOption1["name"] as! String!
        } else {
            switch buttonWithTheRightAnswer {
            case 1:
                correctFlag = countryOption1["flagImg"] as! String!
                correctName = countryOption1["name"] as! String!
            case 2:
                correctFlag = countryOption2["flagImg"] as! String!
                correctName = countryOption2["name"] as! String!
            case 3:
                correctFlag = countryOption3["flagImg"] as! String!
                correctName = countryOption3["name"] as! String!
            case 4:
                correctFlag = countryOption4["flagImg"] as! String!
                correctName = countryOption4["name"] as! String!
            case 5:
                correctFlag = countryOption5["flagImg"] as! String!
                correctName = countryOption5["name"] as! String!
            default:
                correctFlag = ""
                correctName = ""
            }
        }
        
        // If we want the user to know country name for the flag, hide country name
        if sourceSegue == "Flag" {
            countryNameLabel.alpha = 0.0
        } else {
            countryNameLabel.alpha = 1.0
        }
        
        countryImage.image = UIImage(named: correctFlag)
        countryNameLabel.text = correctName
    }
    
    func generateRandomIndexesAsNeeded() {
        var undesiredIndices = [Int]()
        
        if sourceSegue == "Capital" {
            undesiredIndices = undesiredCapitalIndices
        } else {
            undesiredIndices = undesiredFlagIndices
        }
        
        // Generate first random number OPTION 1
        repeat {
            countryOption1Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
        } while undesiredIndices.contains(countryOption1Index)
        
        if sourceSegue != "Region" {
            repeat { // OPTION 2
                countryOption2Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
            } while countryOption1Index == countryOption2Index || undesiredIndices.contains(countryOption2Index)
            
            repeat { // OPTION 3
                countryOption3Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
            } while countryOption3Index == countryOption1Index || countryOption3Index == countryOption2Index || undesiredIndices.contains(countryOption3Index)
        
            repeat { // OPTION 4
                countryOption4Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
            } while countryOption4Index == countryOption1Index || countryOption4Index == countryOption2Index || countryOption4Index == countryOption3Index || undesiredIndices.contains(countryOption4Index)
        
            repeat { // OPTION 5
                countryOption5Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
            } while countryOption5Index == countryOption1Index || countryOption5Index == countryOption2Index || countryOption5Index == countryOption3Index || countryOption5Index == countryOption4Index || undesiredIndices.contains(countryOption5Index)
        }
    }
}


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
