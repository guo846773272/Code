//
//  OrExpression.swift
//  InterpreterPattern
//
//  Created by gmy on 2025/5/22.
//

import UIKit

class OrExpression: Expression {
    private var expr1: Expression? = nil
    private var expr2: Expression? = nil
    
    init(expr1: Expression?, expr2: Expression?) {
        self.expr1 = expr1
        self.expr2 = expr2
    }
    
    func interpret(context: String) -> Bool {
        if let expr1 = expr1,
           let expr2 = expr2 {
            return expr1.interpret(context: context) || expr2.interpret(context: context)
        }
        return false
    }
}
