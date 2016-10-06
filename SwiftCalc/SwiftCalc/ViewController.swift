//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    // the action sequence will be first number pressed, operator pressed, and second number pressed
    var action_seq: [String] = ["", "", ""]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        resultLabel.text = content
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        var result = 0
        if operation ==  "/" {
            result = a / b
        } else if operation == "*" {
            result = a * b
        } else if operation == "-" {
            result = a - b
        } else if operation == "+" {
            result = a + b
        } else if operation == "=" {
            result = a
        } else {
            result = 0
        }
        return result
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        // need to cast first
        let a = Double(a)!
        let b = Double(b)!
        var result = 0.0
        if operation ==  "/" {
            result = a / b
        } else if operation == "*" {
            result = a * b
        } else if operation == "-" {
            result = a - b
        } else if operation == "+" {
            result = a + b
        } else if operation == "=" {
            result = a
        } else {
            result = 0
        }
        return result
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        // Fill me in!
        if action_seq[0] != "" {
            if action_seq[1] != "" {
                if action_seq[2] != "" {
                    // always check for number of characters
                    if (action_seq[2].characters.count < 7) {
                        action_seq[2] += sender.content
                        updateResultLabel(action_seq[2])
                    }
                } else {
                    action_seq[2] = sender.content
                    updateResultLabel(action_seq[2])
                }
            } else {
                // always check for number of characters
                if (action_seq[0].characters.count < 7) {
                    action_seq[0] += sender.content
                    updateResultLabel(action_seq[0])
                }
            }
        } else{
            action_seq[0] = sender.content
            updateResultLabel(action_seq[0])
        }
        // result is always stored at index 0
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        guard String(sender.content) != nil else { return }
        // Fill me in!
        print("The op \(sender.content) was pressed")
        if (sender.content == "C") {
            action_seq[0] = ""
            action_seq[1] = ""
            action_seq[2] = ""
            updateResultLabel("0")
        }
        if action_seq[1] != "" {
            if (sender.content == "+/-") {
                if ((action_seq[2].characters.count < 7) && (action_seq[2] != "")) {
                    let num = Int(action_seq[2])!
                    let neg = 0 - num
                    action_seq[2] = String(neg)
                    updateResultLabel(String(neg))
                }
            } else if (sender.content == "%") {
                let per = Int(action_seq[0])! / 100
                action_seq[0] = String(per)
                updateResultLabel(action_seq[0])
            } else {
                if (action_seq[0] == "") {
                    action_seq[1] = sender.content
                    calculate()
                } else {
                    if (action_seq[2] != "") {
                        // update the resultlabel with the result of calculating a and b
                        //let a = Int(action_seq[0])
                        //let b = Int(action_seq[2])
                        let ret = calculate(a: action_seq[0], b: action_seq[2], operation: action_seq[1])
                        updateResultLabel(ret.prettyOutput)
                        action_seq[0] = ret.prettyOutput
                        if (sender.content == "=") {
                            action_seq[1] = ""
                        } else {
                            action_seq[1] = sender.content
                        }
                        action_seq[2] = ""
                    }
                }
            }
            
        } else{
            if (sender.content == "+/-") {
                if ((action_seq[0].characters.count < 7) && (action_seq[0] != "")) {
                    let num = Int(action_seq[0])!
                    let neg = 0 - num
                    action_seq[0] = String(neg)
                    updateResultLabel(String(neg))
                }
            } else if (sender.content == "=") {
                let ret = calculate(a: action_seq[0], b: action_seq[2], operation: sender.content)
                updateResultLabel(ret.prettyOutput)
                action_seq[0] = ret.prettyOutput
                action_seq[1] = ""
                action_seq[2] = ""

            } else {
                action_seq[1] = sender.content
            }
        }
        // always store the result at action_seq 0
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        // get the button and decide which operator to do
        if (sender.content == "0") {
            // 0 gets added to the end if entering first number, or
            if ((action_seq[1] == "") && (action_seq[0].characters.count < 7)) {
                action_seq[0] += sender.content
                updateResultLabel(action_seq[0])
            } else if ((action_seq[1] != "") && (action_seq[2].characters.count < 7)) {
                action_seq[2] += sender.content
                updateResultLabel(action_seq[2])
            }
        } else if (sender.content == ".") {
            // if decimal was pressed for the first number, then for second number
            if (action_seq[0].contains(".") == false) {
                if action_seq[0] == "" {
                    action_seq[0] = "0."
                    updateResultLabel(action_seq[0])
                }
                else if (action_seq[0].characters.count < 7) {
                    action_seq[0] += "."
                    updateResultLabel(action_seq[0])
                }
            }  else if ((action_seq[2].contains(".") == false) && (action_seq[1] != "")) {
                if action_seq[2] == "" {
                    action_seq[2] = "0."
                    updateResultLabel(action_seq[2])
                }
                else if (action_seq[2].characters.count < 7) {
                    action_seq[2] += "."
                    updateResultLabel(action_seq[2])
                }
            }
            
        } else {
            numberPressed(sender)
        }
        
       // Fill me in!

    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

