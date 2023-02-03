//
//  APIService.swift
//  Rides
//
//  Created by ajey raj on 31/01/23.
//

import Foundation

struct APIService {
    var baseUrl = "https://random-data-api.com/api/vehicle/random_vehicle"
    
    func GetVechileListWithSize(size: Int, completionHandler:@escaping (VechicleInfos?)->()) {
        let Ep : String = "\(baseUrl)?size=\(size)"
        guard let url = URL(string: Ep) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let safeError = error {
                print("[API Service] URL failure \(safeError)")
                return
            }
            if let safeData = data {
                let data = ParseJson(data: safeData)
                completionHandler(data)
            }
        }
        task.resume()
    }
    
    func ParseJson(data: Data) -> VechicleInfos? {
        let decoder = JSONDecoder()
        do{
            let vechicleData = try decoder.decode(VechicleInfos.self, from: data)
            return vechicleData
        } catch {
            print("[API service] Parsing failed : \(error)")
        }
        return nil
    }
}
