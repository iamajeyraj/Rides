//
//  CarCellViewModel.swift
//  Rides
//
//  Created by ajey raj on 01/02/23.
//

import Foundation

struct CarDataViewModel {
    var vechicleData : VechicleData?
    let firstCarbon: Double = 5000
    
    init(vechicleInfo: VechicleData) {
        vechicleData = vechicleInfo
    }
    
    func GetMakeAndModel(metaInfo:Bool) -> String {
        if let vechicleInfo = vechicleData {
            if metaInfo{
                return "Model: \(vechicleInfo.make_and_model)"
            } else {
                return "\(vechicleInfo.make_and_model)"
            }
                
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
            return "Color: \(vechicleInfo.color)"
        }
        return ""
    }
    
    func GetCarType() -> String {
        if let vechicleInfo = vechicleData {
            return "Car Type: \(vechicleInfo.car_type)"
        }
        return ""
    }
    
    func GetCarbonEmission()->String?{
        guard let vechicleData = vechicleData else {
            return "0"
        }

        var carbonEmission = 0.0
        if(vechicleData.kilometrage > firstCarbon) {
            let delta = vechicleData.kilometrage - firstCarbon //first 5000
            let finalVal = (delta * 1.5) + firstCarbon
            carbonEmission = finalVal
        } else {
            carbonEmission = vechicleData.kilometrage * 1
        }
        
        return "Carbon Emission: \(Int(carbonEmission))"
    }
    
    func GetKilometerage()-> String? {
        if let vechicleInfo = vechicleData {
            return "Kilometer: \(Int(vechicleInfo.kilometrage))"
        }
        return "Error"
    }
}
