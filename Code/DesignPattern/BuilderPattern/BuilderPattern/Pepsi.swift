//
//  Pepsi.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class Pepsi: ColdDrink {
    override func price() -> Float {
        return 35.0
    }
    
    override func name() -> String {
        return "Pepsi"
    }
}
