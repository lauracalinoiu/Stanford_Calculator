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
  private var internalProgram: [PropertyList] = []
  let M = "M"
  
  func setOperand(operand: Double){
    accumulator = operand
    internalProgram.append(operand)
  }
  
  func setOperand(variableName: String){
    variableValues[variableName] = 0.0
    accumulator = 0.0
    internalProgram.append(variableName)
  }
  var variableValues = Dictionary<String, Double>()
  
  private enum Operation{
    case Constant(Double)
    case UnaryOperation(Double -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
  }
  
  private var operations: Dictionary<String, Operation> = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "Rand": Operation.Constant(Double(arc4random())),
    "√" : Operation.UnaryOperation(sqrt),
    "cos": Operation.UnaryOperation(cos),
    "sin": Operation.UnaryOperation(sin),
    "tan": Operation.UnaryOperation(tan),
    "1/x": Operation.UnaryOperation({1/$0}),
    "×": Operation.BinaryOperation(*),
    "÷": Operation.BinaryOperation(/),
    "+": Operation.BinaryOperation(+),
    "-": Operation.BinaryOperation(-),
    "=": Operation.Equals
  ]
  
  func performOperation(symbol: String){
    internalProgram.append(symbol)
    
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
  
  var postfix: String{
    get{
      if isPartialResult{
        return "..."
      }
      return ""
    }
  }
  private var isPartialResult: Bool{
    get{
      return pending != nil
    }
  }
  
  typealias PropertyList = AnyObject
  var program: [PropertyList]{
    get{
      return internalProgram
    }
    set{
      clear()
      for op in newValue{
        if let operand = op as? Double{
          setOperand(operand)
        } else if let operation = op as? String{
          if operation == M{
            setOperand(variableValues[M]!)
          } else{
            performOperation(operation)
          }
        }
      }
    }
  }
  
  var description: String{
    get{
      var d = ""
      for op in internalProgram{
        if let operand = op as? Double{
          d = d + "\(operand)"
        } else if let operation = op as? String{
          d = d + operation
        }
      }
      
      return d
    }
    
  }
  func clear(){
    pending = nil
    setOperand(0.0)
    accumulator = 0.0
    internalProgram.removeAll()
  }
}