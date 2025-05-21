//
//  Item.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

protocol Item {
    func name() -> String;
    func packing() -> Packing;
    func price() -> Float;
}
