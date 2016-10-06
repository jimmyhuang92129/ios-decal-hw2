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
    var someDataStructure = "0"
    var oldDataStructure = ""
    var currentOperator = ""
    var result = 0.0

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

        // Doesnt change display if user enters a "0" when display is already "0"
        if someDataStructure == "0" && content == "0"{
            someDataStructure = "0"
        }
            
        // Adds user's number input to someDataStructure if display is "0"
        else if someDataStructure == "0" && content != "0" && content != "C"{
            someDataStructure.append(content)
            someDataStructure.remove(at:someDataStructure.startIndex)
        }
        
        // Resests all variables when "C" button is pushed
        else if content == "C"{
            someDataStructure = "0"
            oldDataStructure = ""
            currentOperator = ""
            result = 0.0
        }
            
        // Removes neg sign to someDataStructure if present at first index and adds neg sign if not originally present
        else if content == "+/-" {
            if someDataStructure.characters.first == "-" {
                someDataStructure.remove(at:someDataStructure.startIndex)
            }
            else {
                someDataStructure.insert("-", at: someDataStructure.startIndex)
            }
        }
        else {
            someDataStructure.append(content)
        }
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        resultLabel.text = someDataStructure
    }
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
//    // TODO: A simple calculate method for integers.
//    //       Modify this one or create your own.
//    func intCalculate(a: Int, b:Int, operation: String) -> Int {
//        print("Calculation requested for \(a) \(operation) \(b)")
//        return 0
//    }
//    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        currentOperator = operation
        
        // Mathamatical calculations depending on if operation parameter is add, subtract, multiply or divide
        if operation == "+"{
            return Double(a)! + Double(b)!
        }
        else if operation == "-"{
            return Double(a)! - Double(b)!
        }
        else if operation == "*"{
            return Double(a)! * Double(b)!
        }
        else if operation == "/"{
            return Double(a)! / Double(b)!
        }
        else {
            return 0.0
        }
    }

    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        
        // Prevents the user's number input of additional numbers if there are already over 7 digits on screen
        if someDataStructure.characters.count > 6 {}
        
        // Sends the user's new number input to be appended to someDataStructure
        else{
            updateSomeDataStructure(sender.content)
            updateResultLabel("dummy")
            
//            print(someDataStructure)
//            print(oldDataStructure)
//            print(currentOperator)
        }
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        
        if sender.content == "="{
            
            // Trigger to calculate only if there is a previous entry and an operator specified
            if someDataStructure != "" && currentOperator != ""{
                if currentOperator == "*" || currentOperator == "/" || currentOperator == "+" || currentOperator == "-" {
                    result = calculate(a:oldDataStructure,b:someDataStructure,operation: currentOperator)
                }
            }
            
            // Remove the ".0" after each type double calculation
            var resultDoubleToString = String(result)
            var lastIndex = resultDoubleToString.characters.count-1
            var secondToLastIndex = lastIndex - 1
            if resultDoubleToString[resultDoubleToString.index(before: resultDoubleToString.endIndex)] == "0" &&
                resultDoubleToString[resultDoubleToString.index(resultDoubleToString.startIndex, offsetBy: secondToLastIndex)] == "."{
                resultDoubleToString.remove(at: resultDoubleToString.index(before: resultDoubleToString.endIndex))
                resultDoubleToString.remove(at: resultDoubleToString.index(before: resultDoubleToString.endIndex))
            }
            
            // Update global variables and display
            oldDataStructure = resultDoubleToString
            someDataStructure = "0"
            resultLabel.text = resultDoubleToString
        }
            
        // Cases for other non-mathematical operators
        else if sender.content == "C"{
            updateSomeDataStructure("C")
            updateResultLabel("dummy")
        }
        else if sender.content == "+/-"{
            updateSomeDataStructure("+/-")
            updateResultLabel("dummy")
        }
        else if sender.content == "%"{
        }
            
        //Trigger to calculate only if there is a previous entry and an operator specified
        else if someDataStructure != "" && currentOperator != ""{
            if currentOperator == "*" || currentOperator == "/" || currentOperator == "+" || currentOperator == "-" {
                result = calculate(a:oldDataStructure,b:someDataStructure,operation: currentOperator)
            }
            
            // Remove the ".0" after each type double calculation
            var resultDoubleToString = String(result)
            var lastIndex = resultDoubleToString.characters.count-1
            var secondToLastIndex = lastIndex - 1
            if resultDoubleToString[resultDoubleToString.index(before: resultDoubleToString.endIndex)] == "0" &&
                resultDoubleToString[resultDoubleToString.index(resultDoubleToString.startIndex, offsetBy: secondToLastIndex)] == "."{
                resultDoubleToString.remove(at: resultDoubleToString.index(before: resultDoubleToString.endIndex))
                resultDoubleToString.remove(at: resultDoubleToString.index(before: resultDoubleToString.endIndex))
            }
            
            // Update global variables and display
            oldDataStructure = resultDoubleToString
            someDataStructure = "0"
            resultLabel.text = resultDoubleToString
            currentOperator = sender.content
            
            //DEBUG
//          print(someDataStructure)
//          print(oldDataStructure)
//          print(currentOperator)

        }
            
        //Case where there is no previous operator specified
        else{
        oldDataStructure = someDataStructure
        someDataStructure = "0"
        currentOperator = sender.content
            
        //DEBUG
//      print(someDataStructure)
//      print(oldDataStructure)
//      print(currentOperator)
        }
    
    }
    
    // REQUIRED: The responder to a 0 or . button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        // Prevents the user's number input of additional numbers if there are already over 7 digits screen
        if someDataStructure.characters.count > 6 {}
        
        // Sends the user's new input to be appended to someDataStructure    
        else{
            updateSomeDataStructure(sender.content)
            updateResultLabel(sender.content)
        }
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

