//
//  ViewController.swift
//  InterpreterPattern
//
//  Created by gmy on 2025/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    //规则：Robert 和 John 是男性
    func getMaleExpression() -> Expression {
        let robert = TerminalExpression(data: "Robert")
        let john = TerminalExpression(data: "John")
        return OrExpression(expr1: robert, expr2: john)
    }
    //规则：Julie 是一个已婚的女性
    func getMarriedWomanExpression() -> Expression {
        let julie = TerminalExpression(data: "Julie")
        let married = TerminalExpression(data: "Married")
        return AndExpression(expr1: julie, expr2: married)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isMale = getMaleExpression()
        let isMarriedWoman = getMarriedWomanExpression()
        print("John is male? \(isMale.interpret(context: "John"))")
        print("Julie is a married women?  \(isMarriedWoman.interpret(context: "Married Julie"))")
        
    }


}

