//
//  TerminalExpression.swift
//  InterpreterPattern
//
//  Created by gmy on 2025/5/22.
//

import UIKit

class TerminalExpression: Expression {
    
    private var data: String = ""
    
    func interpret(context: String) -> Bool {
        return context.contains(data)
    }
    
    init(data: String) {
        self.data = data
    }
}
