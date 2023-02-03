//
//  ViewController.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import UIKit

class MainViewController: UIViewController, APIDataSource {
    
    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var carListTableViewController: UITableView!
    @IBOutlet weak var vinButton: UIButton!
    @IBOutlet weak var carTypeButton: UIButton!
    var carVM = MainViewModel()
    let segueIdentifier = "details"
    
    override func viewDidLoad() {
        Init()
    }
    
    func Init() {
        sizeField.delegate = self;
        carVM.delegate = self
        carListTableViewController.delegate = self
        carListTableViewController.dataSource = self
    }
    
    @IBAction func OnSearchDone(_ sender: UIButton) {
        carVM.FetchData(sizeText: sizeField.text)
        sizeField.endEditing(true)
    }
    
    @IBAction func OnCarTypeClicked(_ sender: UIButton) {
        carVM.ChangeSortType(sortType: .CAR_TYPE)
        HighLightButton()
        DispatchQueue.main.async { [self] in
            carListTableViewController.reloadData()
        }
    }
    
    @IBAction func OnVinSortClicked(_ sender: UIButton) {
        carVM.ChangeSortType(sortType: .VIN)
        HighLightButton()
        DispatchQueue.main.async { [self] in
            carListTableViewController.reloadData()
        }
    }
    
    func HighLightButton() {
        DispatchQueue.main.async { [self] in
            vinButton.isSelected = carVM.GetCurrentSortType() == .VIN
            carTypeButton.isSelected = carVM.GetCurrentSortType() == .CAR_TYPE
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let safevechicleData = carVM.GetSelectedCar() {
                let detailVC = segue.destination as! CarDetailsViewController
                detailVC.carDetails = safevechicleData
            }
        }
    }
    
    func SetVechicleData(dataFetched: Bool,error: String) {
        if dataFetched {
            self.HighLightButton()
            self.carListTableViewController.reloadData()
        }else{
            print("[Main View Controller] Error : \(error)")
        }
    }
}

