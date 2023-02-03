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
    var selectedCar : CarDataViewModel?
    
    func GetPlaceholderText(value: String?) -> String {
        var placeHolder = "Enter number of cars. Eg.9"
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
        if CheckGivenValueValid(sizeText: sizeText)  {
            ResetValues()
            guard let size = sizeText else { return }
            guard let sizeInt = Int(size) else { return }
            service.GetVechileListWithSize(size: sizeInt) { carData in
                guard var vechicleData = carData else {
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
            
        }
    }
    
    func CheckGivenValueValid(sizeText: String?)-> Bool {
        if let safeSizeText = sizeText {
            if let safeSizeIntText = safeSizeText.rangeOfCharacter(from: NSCharacterSet.decimalDigits)
            {
                if let sizeInt = Int(safeSizeText) {
                    if (1...100).contains(sizeInt) {
                        return true
                    }else{
                        self.delegate?.SetVechicleData(dataFetched: false,
                                                       error: "Enter value between 1 and 100")
                    }
                }
            } else {
                self.delegate?.SetVechicleData(dataFetched: false,
                                               error: "Please give a numberic value")
            }
        }else{
            self.delegate?.SetVechicleData(dataFetched: false, error: "Please enter a value")
        }
        
        return false
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
    
    func GetCarDetailForRow(section: Int, row:Int) -> CarDataViewModel?{
        if currSort == .CAR_TYPE {
            if let safeDetail = GetVechileDetailBySection(sectionIndex: section) {
                return CarDataViewModel(vechicleInfo: safeDetail[row])
            }
        }
        
        return CarDataViewModel(vechicleInfo: vechicleByVin[row])
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
    
    func GetSelectedCar() -> CarDataViewModel?{
        return selectedCar
    }
}

protocol APIDataSource {
    func SetVechicleData(dataFetched: Bool, error :String)
}
