//
//  ChickenBurger.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class ChickenBurger: Burger {
    override func price() -> Float {
        return 50.5
    }
    
    override func name() -> String {
        return "Chicken Burger"
    }
}
