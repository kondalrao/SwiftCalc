//
//  AppDelegate.swift
//  SwiftMacApp
//
//  Created by Kondal Rao Komaragiri on 9/4/14.
//  Copyright (c) 2014 Kondal Rao Komaragiri. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var simpleCalc: NSWindow!
    @IBOutlet weak var lblResult: NSTextField!
    @IBOutlet weak var lblOper: NSTextFieldCell!

    var memValue: NSString! = "0"
    var prevNum: NSString! = "0"
    var result: NSString! = "0"
    var oper: NSString! = ""
    
    let operType: [String:String] = [ "":  "[                                ]",
                                      "+": "[                    +           ]",
                                      "-": "[                    -           ]",
                                      "x": "[                    x           ]",
                                      "/": "[                    /           ]"]
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Initialization
        lblResult.stringValue = "0"
        lblOper.stringValue = operType[""]
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
        self
    }
    
    func updateResult(res: NSString!) {
        lblResult.stringValue = res
    }

    func calculate(op: NSString) {
        var res: Double = result.doubleValue
        var n1: Double = prevNum.doubleValue
        
        switch(op) {
        case "+":
            oper = "+"
            if prevNum != "0" {
                prevNum = "\(n1 + res)"
            }
        case "-":
            oper = "-"
            if prevNum != "0" {
                prevNum = "\(n1 - res)"
            }
        case "x":
            oper = "x"
            if prevNum != "0" {
                prevNum = "\(n1 * res)"
            }
        case "/":
            oper = "/"
            if prevNum != "0" {
                prevNum = "\(n1 / res)"
            }
        default:
            println("Hitting default operator \(op)")
        }
        
        println("Calculation \(n1) \(oper) \(res) = \(prevNum)")
    }
    
    func clear() {
        oper = ""
        prevNum = "0"
        result = "0"
    }
    
    @IBAction func btnFuncAction(btnFunc: NSButton) {
        //println(btnFunc.title)
        
        clear()
        updateResult("0")
    }
    
    @IBAction func btnMemAction(btnMem: NSButton) {
        println(btnMem.title)
        var res: Double = result.doubleValue
        var mem: Double = memValue.doubleValue
        
        if btnMem.title == "MC" {
            memValue = "0"
        } else if btnMem.title == "MR" {
            result = memValue
            updateResult(memValue)
            return
        } else if btnMem.title == "M+" {
            memValue = "\(mem + res)"
        } else if btnMem.title == "M-" {
            memValue = "\(mem - res)"
        }
        
        clear()
        
    }

    @IBAction func btnOperatorAction(btnOper: NSButton) {
        if btnOper.title == "=" {
            println("Calculating using operator \(btnOper.title)")
            calculate(oper)
            oper = ""
            println("Clearing the operator")
        } else if btnOper.title == "+/-" {
            result = "\(result.doubleValue * (-1))"
            updateResult(result)
            return
        } else if oper != "" {
            println("Calculating using operator \(oper)")
            calculate(oper)
            oper = btnOper.title
        } else {
            oper = btnOper.title
            println("Setting the operator \(oper)")
        }
        
        if prevNum == "0" {
            prevNum = result
        }

        if btnOper.title == "=" {
            lblOper.stringValue = operType[""]
        } else if btnOper != "+/-" {
            lblOper.stringValue = operType[btnOper.title]
        }
        
        result = "0"
        updateResult(prevNum)
    }
    
    @IBAction func btnDigitAction(btnDigit: NSButton) {
        //println(btnDigit.title)
        
        if result.length >= 10 {
            return
        }
        
        if result == "0" {
            result = btnDigit.title
        } else {
            result = result + btnDigit.title
        }
     
        updateResult(result)
    }
}

