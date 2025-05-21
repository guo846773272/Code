//
//  ColdDrink.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class ColdDrink: Item {
    func name() -> String {
        return "Cold Drink"
    }
    
    func packing() -> any Packing {
        return Bottle()
    }
    
    func price() -> Float {
        return 0.0
    }
}
