//
//  VegBurger.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class VegBurger: Burger {
    override func price() -> Float {
        return 25.0
    }
    
    override func name() -> String {
        return "Veg Burger"
    }
}
