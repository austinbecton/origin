//
//  WeatherSnapshotEnum.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/26/21.
//

import Foundation

enum WeatherSnapshotEnum: String {
    
    case unknown = "Unknown"
    case location = "Location"
    case currenttemp = "Now"
    case currentHumidity = "Humidity"
    case currentHighTemp = "Today's High"
    case currentLowTemp = "Today's Low"
    case currentCondition = "Conditions"
    
    case tomorrowHigh = "Tomorrow's High"
    case tomorrowLow = "Tomorrow's Low"
    case tomorrowHumidity = "Tomorrow's Humidity"
    case tomorrowCondition = "Tomorrow's Conditions"
    
}
