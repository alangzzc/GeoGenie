//
//  QuizAreaPopulationVC.swift
//  GeoGenie
//
//  Created by Alan Gonzalez on 1/27/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//

import UIKit

class QuizAreaPopulationVC: UIViewController, UICircularProgressRingDelegate {
    
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
    
    var countryOption1Index : Int! { didSet {if countryOption1Index == nil {countryOption1Index = 0}}}
    var countryOption2Index : Int! { didSet {if countryOption2Index == nil {countryOption2Index = 0}}}
    
    var option1Value : Double! { didSet {if option1Value == nil {option1Value = 0.0}}}
    var option2Value : Double! { didSet {if option2Value == nil {option2Value = 0.0}}}
    
    let undesiredAreaIndices       = [8,27,30,58,77,79,89,116,137,140,155,168,179,183,184,185,187,199,205,207,212,244] //
    let undesiredPopulationIndices = [8,27,30,58,77,79,89,116,        155,168,179,183,    185,187,199,207,    212,244] // 30 Pop = 0
    
    let deselectedRight: UIColor = UIColor.green
    let deselectedWrong: UIColor = UIColor.red
    let deselectedBegin: UIColor = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1.0) // default value
    
    var alertTile = String()
    var alertMessage = String()
    
    @IBOutlet weak var countryImage1: UIImageView!
    @IBOutlet weak var countryImage2: UIImageView!
    @IBOutlet weak var buttonOption1: ZFRippleButton!
    @IBOutlet weak var buttonOption2: ZFRippleButton!
    @IBOutlet weak var answerOption1: UILabel!
    @IBOutlet weak var answerOption2: UILabel!
    @IBOutlet weak var star1: DOFavoriteButton!
    @IBOutlet weak var star2: DOFavoriteButton!
    @IBOutlet weak var star3: DOFavoriteButton!
    @IBOutlet weak var star4: DOFavoriteButton!
    @IBOutlet weak var star5: DOFavoriteButton!
    @IBOutlet weak var backButton: DynamicButton!
    @IBOutlet weak var newButton: DynamicButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = sourceSegue
        
        if !babyMode {
            // Hide answers if not playing in BabyMode
            answerOption1.alpha = 0.0
            answerOption2.alpha = 0.0
        }
        
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
        
        beginNewQuestion()
    }
    
    @IBAction func backButton(_ sender: DynamicButton) {
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
                    self.beginNewQuestion()
                })
            } else {
                showGradeProgressRings()
            }
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
    
    
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        if score > 0 {
            sleep(1)
            showNewGameAlert()
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
    
    func showNewGameAlert() {
        let alertGameOver = UIAlertController(title: alertTile, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertGameOver.addAction(UIAlertAction.init(title: "Back", style: UIAlertActionStyle.default, handler: {alertGameOver in self.dismiss(animated: true, completion: nil)}))
        alertGameOver.addAction(UIAlertAction.init(title: "NEW", style: UIAlertActionStyle.default, handler: {alertGameOver in
            self.newGame()}))
        self.present(alertGameOver, animated: true, completion:nil)
    }
    
    func setButtonsTextValues() {
        buttonOption1.setTitle("\(option1Value!)", for: UIControlState.normal)
        buttonOption2.setTitle("\(option2Value!)", for: UIControlState.normal)
    }
    
    func getAllOptionsValues() {
        if sourceSegue == "Area" {
            option1Value = countryOption1["area"] as! Double
            option2Value = countryOption2["area"] as! Double
        } else if sourceSegue == "Population" {
            option1Value = countryOption1["population"] as! Double
            option2Value = countryOption2["population"] as! Double
        }
    }
    
    func resetAllValuesToDefault() {
        option1Value = 0.0
        option2Value = 0.0
        countryOption1Index = 0
        countryOption2Index = 0
        countryOption1 = ["" : ""]
        countryOption2 = ["" : ""]
        buttonWithTheRightAnswer = 0
        buttonOption1.rippleColor = deselectedWrong
        buttonOption2.rippleColor = deselectedWrong
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
    }
    
    func pickCorrectAnswer() {
        if option1Value! > option2Value! {
            buttonWithTheRightAnswer = 1
        } else {
            buttonWithTheRightAnswer = 2
        }
        
        manageButtonRippleColorBasedOnCurrentRightAnswer()
    }
    
    func manageButtonRippleColorBasedOnCurrentRightAnswer() {
        if buttonWithTheRightAnswer == 1 {
            buttonOption1.rippleColor = deselectedRight
        } else if buttonWithTheRightAnswer == 2 {
            buttonOption2.rippleColor = deselectedRight
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
        showFlagAndCountryName()
    }
    
    func showFlagAndCountryName() {
        
        countryImage1.image = UIImage(named: countryOption1["flagImg"] as! String!)
        countryImage2.image = UIImage(named: countryOption2["flagImg"] as! String!)
        
        buttonOption1.setTitle(countryOption1["name"] as! String!, for: .normal)
        buttonOption2.setTitle(countryOption2["name"] as! String!, for: .normal)
        
        if sourceSegue == "Population" {
            if option1Value > 1000000 {
                //valueToShow1 = option1Value / 1000000
                answerOption1.text = "\((option1Value / 1000000).withCommas()) M"
            } else {
                //valueToShow1 = option1Value / 1000
                answerOption1.text = "\(option1Value.withCommas())"
            }
            
            if option2Value > 1000000 {
                answerOption2.text = "\((option2Value / 1000000).withCommas()) M"
                //valueToShow2 = option2Value / 1000000
            } else {
                answerOption2.text = "\(option2Value.withCommas())"
                //valueToShow2 = option2Value / 1000
            }
        } else {
            answerOption1.text = "\(option1Value.withCommas())"
            answerOption2.text = "\(option2Value.withCommas())"
        }
    }
    
    func generateRandomIndexesAsNeeded() {
        var undesiredIndices = [Int]()
        
        if sourceSegue == "Area" {
            undesiredIndices = undesiredAreaIndices
        } else if sourceSegue == "Population" {
            undesiredIndices = undesiredPopulationIndices
        }
        
        // Generate first random number OPTION 1
        repeat {
            countryOption1Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
        } while undesiredIndices.contains(countryOption1Index)
        
        // Generate second random number OPTION 2
        repeat {
            countryOption2Index = countries!.index(countries!.startIndex, offsetBy: countries!.count.arc4random)
        } while countryOption1Index == countryOption2Index || undesiredIndices.contains(countryOption2Index)
    }
}
