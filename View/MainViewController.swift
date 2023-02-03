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
    @IBOutlet weak var activityControl: UIActivityIndicatorView!
    
    @IBOutlet weak var helperText: UILabel!
    
    var carVM = MainViewModel()
    let segueIdentifier = "page"
    
    override func viewDidLoad() {
        Init()
    }
    
    func Init() {
        sizeField.delegate = self;
        carVM.delegate = self
        carListTableViewController.delegate = self
        carListTableViewController.dataSource = self
        StopSpinnerAnimation()
    }
    
    @IBAction func OnSearchDone(_ sender: UIButton) {
        StartSpinnerAnimation()
        helperText.isHidden = true
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
                let detailVC = segue.destination as! CollectionViewController
                detailVC.vechicleData = safevechicleData
            }
        }
    }
    
    func SetVechicleData(dataFetched: Bool,error: String) {
        StopSpinnerAnimation()
        if dataFetched {
            self.HighLightButton()
            self.carListTableViewController.reloadData()
        } else {
            CreateAlert(title: "Validation Failed", message: error)
            print("[Main View Controller] Error : \(error)")
        }
    }
    
    func StartSpinnerAnimation(){
        activityControl.startAnimating()
        activityControl.isHidden = false
    }
    
    func StopSpinnerAnimation(){
        activityControl.stopAnimating()
        activityControl.isHidden = true
    }
    
    func CreateAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

