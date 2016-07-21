//
//  ViewController.swift
//  Assign1_Calculator
//
//  Created by Laura Calinoiu on 15/07/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private weak var display: UILabel!
  @IBOutlet weak var debugDisplay: UILabel!
  private var userIsInMiddleOfEditing = false
  
  @IBAction private func numberPressed(sender: UIButton) {
    let item = sender.currentTitle
    
    if userIsInMiddleOfEditing{
      let savedOldDisplay = display.text!
      display.text = display.text! + item!
      
      if displayValue == nil{
        display.text = savedOldDisplay
      }
    } else{
      display.text = item
    }
    userIsInMiddleOfEditing = true
  }
  
  private var displayValue: Double?{
    get{
      return Double(display.text!)
    }
    set{
      display.text = String(newValue!)
    }
  }
  
  private var calculatorBrain = CalculatorBrain()
  
  @IBAction private func operationPerformed(sender: UIButton) {
    if userIsInMiddleOfEditing{
      calculatorBrain.setOperand(displayValue!)
      userIsInMiddleOfEditing = false
    }
    
    if let mathematicalSymbol = sender.currentTitle{
      calculatorBrain.performOperation(mathematicalSymbol)
    }

    displayValue = calculatorBrain.result
    debugDisplay.text = calculatorBrain.description + calculatorBrain.postfix
  }

  @IBAction func clearDisplaysAndStates(sender: UIButton) {
    display.text = "0"
    debugDisplay.text = " "
    calculatorBrain.clear()
  }
}

