//
//  CalculatorBrain.swift
//  Assign1_Calculator
//
//  Created by Laura Calinoiu on 18/07/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import Foundation

class CalculatorBrain{
  
  private var accumulator = 0.0
  
  func setOperand(operand: Double){
    accumulator = operand
  }
  
  private enum Operation{
    case Constant(Double)
    case UnaryOperation(Double -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  private var operations: Dictionary<String, Operation> = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "√" : Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
    "x": Operation.BinaryOperation(*),
    "÷": Operation.BinaryOperation(/),
    "+": Operation.BinaryOperation(+),
    "-": Operation.BinaryOperation(-),
    "=": Operation.Equals
  ]
  
  func performOperation(symbol: String){
    if let operation = operations[symbol]{
      switch operation{
      case .Constant(let value) :
        accumulator = value
      case .UnaryOperation(let function) :
        accumulator = function(accumulator)
      case .BinaryOperation(let operation):
        executePendingOperation()
        pending = PendingBinaryOperationInfo(binaryFunction: operation, firstOperand: accumulator)
      case .Equals:
        executePendingOperation()
      }
    }
  }
  
  private func executePendingOperation(){
    if pending != nil{
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      pending = nil
    }
  }
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo{
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
  }
  
  var result: Double{
    get{
      return accumulator
    }
  }
}