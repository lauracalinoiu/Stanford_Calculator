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
  private var userIsInMiddleOfEditing = false
  
  @IBAction private func numberPressed(sender: UIButton) {
    let item = sender.currentTitle
    if userIsInMiddleOfEditing{
      display.text = display.text! + item!
    } else{
      display.text = item
    }
    userIsInMiddleOfEditing = true
  }
  
  private var displayValue: Double{
    get{
      return Double(display.text!)!
    }
    set{
      display.text = String(newValue)
    }
  }
  
  private var calculatorBrain = CalculatorBrain()
  
  @IBAction private func operationPerformed(sender: UIButton) {
    if userIsInMiddleOfEditing{
      calculatorBrain.setOperand(displayValue)
      userIsInMiddleOfEditing = false
    }
    
    if let mathematicalSymbol = sender.currentTitle{
      calculatorBrain.performOperation(mathematicalSymbol)
    }

    displayValue = calculatorBrain.result
  }
}

