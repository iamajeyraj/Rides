//
//  ExtendedCarDetailsController.swift
//  Rides
//
//  Created by ajey raj on 02/02/23.
//

import UIKit

class ExtendedCarDetailsController: UIViewController {
    
    @IBOutlet weak var carbonValue: UILabel!
    @IBOutlet weak var kilometerage: UILabel!
    
    var carDetails : CarDataViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let carDataVM = carDetails else{
            return
        }
        kilometerage.text = carDataVM.GetKilometerage()
        carbonValue.text = carDataVM.GetCarbonEmission()
    }
}
