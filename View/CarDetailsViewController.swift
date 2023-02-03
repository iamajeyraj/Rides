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
    
    var carDetails : VechicleData? {
        didSet { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            guard let vechicleInfo = carDetails else {
                return
            }
            vinLabel.text = vechicleInfo.vin
            modelValue.text = vechicleInfo.make_and_model
            colorLabel.text = vechicleInfo.color
            carType.text = vechicleInfo.car_type
    }
}
