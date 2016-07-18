//
//  ViewController.swift
//  Assign1_Calculator
//
//  Created by Laura Calinoiu on 15/07/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var display: UILabel!
  var userIsInMiddleOfEditing = false
  
  @IBAction func numberPressed(sender: UIButton) {
    let item = sender.currentTitle
    if userIsInMiddleOfEditing{
      display.text = display.text! + item!
    } else{
      display.text = item
    }
    userIsInMiddleOfEditing = true
  }
  
  @IBAction func operationPerformed(sender: UIButton) {
    userIsInMiddleOfEditing = false
    if let currentTitle = sender.currentTitle{
      if currentTitle == "π" {
        display.text = "\(M_PI)"
      }
    }
  }
}

