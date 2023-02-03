//
//  VechicleModel.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import Foundation

struct VechicleData : Codable {
    let vin: String
    let make_and_model : String
    let car_type:String
    let color:String
    let kilometrage : Double
}
typealias VechicleInfos = [VechicleData]
