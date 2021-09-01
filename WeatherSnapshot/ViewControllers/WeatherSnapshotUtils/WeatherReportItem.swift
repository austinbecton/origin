//
//  WeatherReportItem.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/26/21.
//

import Foundation

struct WeatherReportItem {
    var data: String = ""
    var type: WeatherSnapshotEnum = .unknown
    
    func getType() -> String {
        return type.rawValue
    }
    
    func getData() -> String {
        return data
    }
    
}
