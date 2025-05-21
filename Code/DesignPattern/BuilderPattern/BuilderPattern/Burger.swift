//
//  Burger.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class Burger: Item {
    func name() -> String {
        return "Burger name"
    }
    
    func packing() -> any Packing {
        return Wrapper()
    }
    
    func price() -> Float {
        return 0.0
    }
    
    
}
