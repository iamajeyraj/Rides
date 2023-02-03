//
//  CarListModelView.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import Foundation
import CoreVideo
import UIKit

class MainViewModel  {
    let service = APIService()
    var vechicleByVin : VechicleInfos = []
    var vechichleByType: [String: VechicleInfos] = [:]
    var vechicleTypeSections : [String] = []
    var delegate: APIDataSource?
    var currSort : SortType = .VIN
    var selectedCar : VechicleData?
    
    func GetPlaceholderText(value: String?) -> String {
        var placeHolder = "Number of cars?"
        guard let safeValue = value else {
            return ""
        }
        
        if safeValue.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
            return placeHolder
        } else {
            placeHolder =  "Numbers only!"
        }
        return placeHolder
    }
    
    func FetchData(sizeText : String?) {
        if let size = sizeText {
            if let sizeInt = Int(size) {
                if (1...100).contains(sizeInt) {
                    ResetValues()
                    service.GetVechileListWithSize(size: sizeInt) { carData in
                        guard var vechicleData = carData else{
                            return
                        }
                        
                        DispatchQueue.main.async {
                            vechicleData.sort { x1, x2 in
                                x1.vin < x2.vin
                            }
                            self.vechicleByVin = vechicleData
                            vechicleData.sort { x1, x2 in
                                x1.car_type < x2.car_type
                            }
                            self.LoadVechicleBySection(vechileInfo: vechicleData)
                            self.delegate?.SetVechicleData(dataFetched: true, error: "")
                        }
                    }
                } else {
                    self.delegate?.SetVechicleData(dataFetched: false, error: "value not in range")
                }
            }
        }
    }
    
    func ResetValues() {
        vechicleByVin  = []
        vechichleByType = [:]
        vechicleTypeSections = []
        selectedCar = nil
    }
    
    func LoadVechicleBySection(vechileInfo : VechicleInfos) {
        for item in vechileInfo {
            if(!vechichleByType.contains {$0.key == item.car_type}){
                vechichleByType.updateValue([item], forKey: item.car_type)
                vechicleTypeSections.append(item.car_type)
            } else {
                var currList = vechichleByType[item.car_type]
                currList?.append(item)
                vechichleByType.updateValue(currList!, forKey: item.car_type)
            }
        }
    }
    
    func ChangeSortType(sortType: SortType) {
        currSort = sortType
    }
    
    func GetCurrentSortType()-> SortType {
        return currSort
    }
    
    func GetSectionName(sectionIndex: Int) -> String? {
        return currSort == .VIN ? "" : vechicleTypeSections[sectionIndex]
    }
    
    func GetVechileDetailBySection(sectionIndex : Int) -> VechicleInfos? {
        if let sectionName = GetSectionName(sectionIndex: sectionIndex){
            return vechichleByType[sectionName]
        }
        return nil
    }
    
    func GetCarDetailForRow(section: Int, row:Int) -> VechicleData?{
        if currSort == .CAR_TYPE {
            if let safeDetail = GetVechileDetailBySection(sectionIndex: section){
                return safeDetail[row]
            }
        }
        
        return vechicleByVin[row]
    }
    
    func GetNumberOfRowsInSection(section:Int) -> Int {
        if currSort == .VIN && vechicleByVin.count > 0 {
            return vechicleByVin.count
        } else if currSort == .CAR_TYPE && vechichleByType.count > 0 {
            if let carDetailExist = GetVechileDetailBySection(sectionIndex: section) {
                return carDetailExist.count
            }
            return 0
        }
        return 0
    }
    
    func GetNumberOFSections()-> Int {
        return currSort == .VIN ? 1 : vechichleByType.count
    }
    
    func UserSelectedAt(section: Int, row:Int) {
        if let safeCarData = GetCarDetailForRow(section: section, row: row){
            selectedCar = safeCarData
        }
    }
    
    func GetSelectedCar() -> VechicleData?{
        return selectedCar
    }
}

protocol APIDataSource {
    func SetVechicleData(dataFetched: Bool, error :String)
}
