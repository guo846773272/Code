//
//  Meal.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class Meal: NSObject {
    var items: [Item] = []
    
    func appendItem(item: Item) {
        items.append(item)
    }
    
    func getCost() -> Float {
        var cost: Float = 0.0
        for item in items {
            cost = cost + item.price()
        }
        return cost;
    }
    
    func showItems() {
        for item in items {
            print("Items: \(item.name())")
            print("Packing: \(item.packing().pack())")
            print("Price: \(item.price())")
        }
    }
}
