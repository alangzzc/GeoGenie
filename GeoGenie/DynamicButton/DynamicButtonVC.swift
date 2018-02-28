//
//  DynamicButtonVC.swift
//  CocoaButtons
//
//  Created by Alan Gonzalez on 1/25/18.
//  Copyright © 2018 MTY Apps. All rights reserved.
//
// arrowDown: downwards arrow ↓
// arrowLeft: leftwards arrow ←
// arrowRight: rightwards arrow →
// arrowUp: upwards arrow ↑
// caretDown: down caret ⌄
// caretLeft: left caret ‹
// caretRight: left caret ›
// caretUp: up caret: ⌃
// checkMark: check mark ✓
// circleClose: close symbol surrounded by a circle
// circlePlus: plus symbol surrounded by a circle
// close: close symbol X
// dot: dot symbol .
// download: downwards triangle-headed arrow to bar ⤓
// fastForward: fast forward ≫
// hamburger: hamburger button ≡
// horizontalLine: horizontal line ―
// horizontalMoreOptions: horizontal more options …
// none: no style
// pause: pause symbol ‖
// play: play symbol ►
// plus: plus symbol +
// stop: stop symbol ◼
// reload: reload symbol ↻
// rewind: rewind ≪
// verticalLine: vertical line |
// verticalMoreOptions: vertical more options ⋮

import UIKit
//import DynamicButton

class DynamicButtonVC: UIViewController {
    var newButton = DynamicButton()
    var newButton2 = DynamicButton()
    var newButton3 = DynamicButton()
    var newButton4 = DynamicButton()
    
    @IBOutlet weak var customButton1: DynamicButton!
    @IBOutlet weak var customButton2: DynamicButton!
    @IBOutlet weak var customButton3: DynamicButton!
    @IBOutlet weak var customButton3a: DynamicButton!
    
    @IBOutlet weak var customButton4: DynamicButton!
    @IBOutlet weak var customButton5: DynamicButton!
    @IBOutlet weak var customButton6: DynamicButton!
    @IBOutlet weak var customButton6a: DynamicButton!
    
    
    @IBOutlet weak var customButton7: DynamicButton!
    @IBOutlet weak var customButton8: DynamicButton!
    @IBOutlet weak var customButton9: DynamicButton!
    @IBOutlet weak var customButton9a: DynamicButton!
    
    @IBOutlet weak var customButton10: DynamicButton!
    @IBOutlet weak var customButton11: DynamicButton!
    @IBOutlet weak var customButton12: DynamicButton!
    @IBOutlet weak var customButton12a: DynamicButton!

    @IBAction func backButton(_ sender: UIButton) {
        //dismiss View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newButton(_ sender: UIButton) {
        newButton =  DynamicButton(frame: CGRect(x: 16, y: 444, width: 66, height: 66))
        newButton2 = DynamicButton(frame: CGRect(x: 90, y: 444, width: 66, height: 66))
        newButton3 = DynamicButton(frame: CGRect(x: 164, y: 444, width: 66, height: 66))
        newButton4 = DynamicButton(frame: CGRect(x: 238, y: 444, width: 66, height: 66))
        
        newButton.setStyle(.reload, animated: true)
        newButton2.setStyle(.rewind, animated: true)
        newButton3.setStyle(.verticalMoreOptions, animated: true)
        newButton4.setStyle(.plus, animated: true)
        
        newButton.layer.cornerRadius = 33
        newButton2.layer.cornerRadius = 33
        newButton3.layer.cornerRadius = 33
        newButton4.layer.cornerRadius = 33
        
        newButton.lineWidth = 6
        newButton2.lineWidth = 6
        newButton3.lineWidth = 6
        newButton4.lineWidth = 6
        
        newButton.strokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.9)
        newButton2.strokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.9)
        newButton3.strokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.9)
        newButton4.strokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.9)
        
        newButton.highlightStokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.8)
        newButton2.highlightStokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.8)
        newButton3.highlightStokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.8)
        newButton4.highlightStokeColor = UIColor(red: 10 / 256, green: 85 / 256, blue: 156 / 256, alpha: 0.8)
        
        newButton.backgroundColor = UIColor.white
        newButton2.backgroundColor = UIColor.white
        newButton3.backgroundColor = UIColor.white
        newButton4.backgroundColor = UIColor.white
        
        newButton.contentEdgeInsets.left = 15
        newButton.contentEdgeInsets.right = 15
        newButton.contentEdgeInsets.bottom = 15
        newButton.contentEdgeInsets.top = 15
        
        newButton2.contentEdgeInsets.left = 15
        newButton2.contentEdgeInsets.right = 15
        newButton2.contentEdgeInsets.bottom = 15
        newButton2.contentEdgeInsets.top = 15
        
        newButton3.contentEdgeInsets.left = 10
        newButton3.contentEdgeInsets.right = 10
        newButton3.contentEdgeInsets.bottom = 10
        newButton3.contentEdgeInsets.top = 10
        
        newButton4.contentEdgeInsets.left = 15
        newButton4.contentEdgeInsets.right = 15
        newButton4.contentEdgeInsets.bottom = 15
        newButton4.contentEdgeInsets.top = 15
        
        self.view.addSubview(newButton)
        self.view.addSubview(newButton2)
        self.view.addSubview(newButton3)
        self.view.addSubview(newButton4)
        
        newButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        sender.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton1.layer.cornerRadius = 33
        customButton2.layer.cornerRadius = 33
        customButton3.layer.cornerRadius = 33
        customButton3a.layer.cornerRadius = 33
        
        customButton4.layer.cornerRadius = 33
        customButton5.layer.cornerRadius = 33
        customButton6.layer.cornerRadius = 33
        customButton6a.layer.cornerRadius = 33
        
        customButton7.layer.cornerRadius = 33
        customButton8.layer.cornerRadius = 33
        customButton9.layer.cornerRadius = 33
        customButton9a.layer.cornerRadius = 33
        
        customButton10.layer.cornerRadius = 33
        customButton11.layer.cornerRadius = 33
        customButton12.layer.cornerRadius = 33
        customButton12a.layer.cornerRadius = 33
        
        customButton1.setStyle(.arrowLeft, animated: true)
        customButton2.setStyle(.arrowUp, animated: true)
        customButton3.setStyle(.caretLeft, animated: true)
        customButton3a.setStyle(.caretUp, animated: true)
        
        customButton4.setStyle(.checkMark, animated: true)
        customButton5.setStyle(.circleClose, animated: true)
        customButton6.setStyle(.close, animated: true)
        customButton6a.setStyle(.circlePlus, animated: true)
        
        customButton7.setStyle(.download, animated: true)
        customButton8.setStyle(.fastForward, animated: true)
        customButton9.setStyle(.hamburger, animated: true)
        customButton9a.setStyle(.rewind, animated: true)
        
        customButton10.setStyle(.horizontalMoreOptions, animated: true)
        customButton11.setStyle(.pause, animated: true)
        customButton12.setStyle(.play, animated: true)
        customButton12a.setStyle(.stop, animated: true)
    }
    
    @objc func buttonTapped(sender: DOFavoriteButton) {
    }
}

/// Diagonal line style: \
//struct MyCustomLine: Style, DynamicButtonBuildable {
//    let pathVector: DynamicButtonPathVector
//
//    init(center: CGPoint, size: CGFloat, offset: CGPoint, lineWidth: CGFloat) {
//        let r = size / 2
//        let c = cos(CGFloat.pi * 0.3)
//        let s = sin(CGFloat.pi * 0.3)
//
//        let p1 = CGMutablePath()
//        p1.move(to: CGPoint(x: center.x + r * c, y: center.y + r * s))
//        p1.addLine(to: CGPoint(x: center.x - r * c, y: center.y - r * s))
//
//        pathVector = DynamicButtonPathVector(p1: p1, p2: p1, p3: p1, p4: p1)
//    }
//
//    /// "MyCustomLine" style.
//    static var styleName: String {
//        return "MyCustomLine"
//    }
//}
//
//let myButton.style = .custom(MyCustomLine.self)

