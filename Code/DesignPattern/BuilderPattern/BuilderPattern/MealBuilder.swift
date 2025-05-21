//
//  MealBuilder.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class MealBuilder: NSObject {
    func prepareVegMeal() -> Meal {
        let meal = Meal()
        meal.appendItem(item: VegBurger())
        meal.appendItem(item: Coke())
        return meal
    }
    
    func prepareNonVegMeal() -> Meal {
        let meal = Meal()
        meal.appendItem(item: ChickenBurger())
        meal.appendItem(item: Pepsi())
        return meal
    }
}
