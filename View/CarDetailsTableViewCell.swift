//
//  CarDetailsTableViewCell.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import UIKit

class CarDetailsTableViewCell: UITableViewCell {
    var carVM : CarDataViewModel?
    var vechicleData : CarDataViewModel? {
        didSet {
            guard let carDataVM = vechicleData else{
                return
            }
            textLabel?.text = carDataVM.GetMakeAndModel(metaInfo: false)
            detailTextLabel?.text = carDataVM.GetVinNumber()
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
