//
//  PageContollerViewModel.swift
//  Rides
//
//  Created by ajey raj on 03/02/23.
//

import Foundation
import UIKit

struct PageControllerViewModel{
    func GetPreviousViewController(currentIndex: Int, carDetailsControllers:[UIViewController]) -> UIViewController {
        if currentIndex == 0 {
            return carDetailsControllers.last!
        } else {
            return carDetailsControllers[currentIndex - 1]
        }
    }
    
    func GetNextPageController(currentIndex: Int, carDetailsControllers:[UIViewController])->UIViewController{
        if currentIndex < carDetailsControllers.count - 1 {
            return carDetailsControllers[currentIndex + 1]
        } else {
            return carDetailsControllers.first!
        }
    }
}
