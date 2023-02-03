//
//  MainViewControllerExtension.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import Foundation
import UIKit

//extension to void cluttering of MainViewController
//TableView extension
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carVM.GetNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carTableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarDetailsTableViewCell
        let carDetails = carVM.GetCarDetailForRow(section: indexPath.section, row: indexPath.row)
        carTableCell.vechicleData = carDetails
        carTableCell.accessoryType = UITableViewCell.AccessoryType.none
        return carTableCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return carVM.GetNumberOFSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return carVM.GetSectionName(sectionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carVM.UserSelectedAt(section: indexPath.section, row: indexPath.row)
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}

//extension to void cluttering of MainViewController
//TextField extension
extension MainViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        carVM.FetchData(sizeText: sizeField.text)
        sizeField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        sizeField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        sizeField.placeholder = carVM.GetPlaceholderText(value: textField.text)
        return true
    }
}

enum SortType {
    case VIN
    case CAR_TYPE
}
