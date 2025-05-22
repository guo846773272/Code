//
//  Expression.swift
//  InterpreterPattern
//
//  Created by gmy on 2025/5/22.
//

import UIKit

protocol Expression {
    func interpret(context: String) -> Bool;
}
