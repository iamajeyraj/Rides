//
//  CarDetailsViewController.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import UIKit

class CarDetailsViewController: UIViewController {
    
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var modelValue: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var carType: UILabel!
    
    var carDetails : CarDataViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let carDataVM = carDetails else{
            return
        }
        
        vinLabel.text = carDataVM.GetVinNumber()
        modelValue.text = carDataVM.GetMakeAndModel(metaInfo: true)
        colorLabel.text = carDataVM.GetColor()
        carType.text = carDataVM.GetCarType()
    }
}
