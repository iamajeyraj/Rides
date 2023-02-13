//
//  RidesTests.swift
//  RidesTests
//
//  Created by ajey raj on 03/02/23.
//

import XCTest
@testable import Rides

class RidesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testVechicleListingsRange() {
        let mainVM = MainViewModel()
        let val = Int.random(in: 0...110)
        let ex1 = (1...100).contains(val)
        let ex2 = mainVM.CheckGivenValueValid(sizeText: "\(val)")
        XCTAssertEqual(ex1, ex2)
    }
    
    func testVechicleEmissionCheck() {
        let value = Double.random(in: 0.0...50000.0)
        let firstCarbon = 5000.0
        let dependency = VechicleData(vin: "TestVin1234", make_and_model: "Test car", car_type: "Test Ford", color: "Test color", kilometrage: value)
        let carDataVM = CarDataViewModel(vechicleInfo: dependency)
        
        var emission = 0.0
        if(value > firstCarbon) {
            let delta = value - firstCarbon //first 5000
            let finalVal = (delta * 1.5) + firstCarbon
            emission = finalVal
        } else {
            emission = value * 1
        }
        
        let ex1 = CarDataViewModel.GetCarbonEmission(carDataVM)
        let ex2 = "Carbon Emission: \(Int(emission))"
        XCTAssertEqual(ex1()!, ex2)
    }
}
