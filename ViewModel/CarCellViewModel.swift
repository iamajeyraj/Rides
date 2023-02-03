//
//  CarCellViewModel.swift
//  Rides
//
//  Created by ajey raj on 01/02/23.
//

import Foundation

struct CarCellViewModel {
    var vechicleData : VechicleData?
    
    func GetMakeAndModel() -> String {
        if let vechicleInfo = vechicleData {
            return vechicleInfo.make_and_model
        }
        return ""
    }
    
    func GetVinNumber() -> String {
        if let vechicleInfo = vechicleData {
            return "Vin: \(vechicleInfo.vin)"
        }
        return ""
    }
    
    func GetColor() -> String {
        if let vechicleInfo = vechicleData {
            return vechicleInfo.color
        }
        return ""
    }
    
    func GetCarType() -> String {
        if let vechicleInfo = vechicleData {
            return vechicleInfo.car_type
        }
        return ""
    }
}
