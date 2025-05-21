//
//  Coke.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class Coke: ColdDrink {
    override func price() -> Float {
        return 30.0
    }
    
    override func name() -> String {
        return "Coke"
    }
}
