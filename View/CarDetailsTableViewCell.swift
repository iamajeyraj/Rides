//
//  CarDetailsTableViewCell.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import UIKit

class CarDetailsTableViewCell: UITableViewCell {
    var carCellVM = CarCellViewModel()
    var vechicleData : VechicleData? {
        didSet {
            carCellVM.vechicleData = vechicleData
            textLabel?.text = carCellVM.GetMakeAndModel()
            detailTextLabel?.text = carCellVM.GetVinNumber()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = .systemGreen
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.contentView.backgroundColor = UIColor.clear
            }
        }
    }
}
