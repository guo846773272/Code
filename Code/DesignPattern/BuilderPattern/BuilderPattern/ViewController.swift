//
//  ViewController.swift
//  BuilderPattern
//
//  Created by gmy on 2025/5/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mealBuilder = MealBuilder()
        let vegMeal = mealBuilder.prepareVegMeal()
        vegMeal.showItems()
        
        print("-------------------")
        
        let nonVegMeal = mealBuilder.prepareNonVegMeal()
        nonVegMeal.showItems()
    }


}

