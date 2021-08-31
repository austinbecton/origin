//
//  weatherSnap.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/11/21.
//

import Foundation



struct WeatherSnap: Codable {
    
    var city: String
    var region: String
    var country: String
    
    var currentTemp: String
    var currentHighTemp: String
    var currentLowTemp: String
    var currentHumidity: String
    var currentCondition: String
    
    var tomorrowHighTemp: String
    var tomorrowLowTemp: String
    var tomorrowHumidity: String
    var tomorrowCondition: String
    
    
    
    
    /*
    init(city: String, country: String) {
        self.city = city
        self.country = country
        
        self.region = ""
        
        self.currentTemp = ""
        self.currentHighTemp = ""
        self.currentLowTemp = ""
        self.currentHumidity = ""
        self.currentCondition = ""
        
        self.tomorrowHighTemp = ""
        self.tomorrowLowTemp = ""
        self.tomorrowHumidity = ""
        self.tomorrowCondition = ""
        
    }
    
    public func getCurrentTemp() -> String {
        return self.currentTemp
    }
    
    public func setCurrentTemp(newTemp: String) -> Void {
        self.currentTemp = "50"
    }
    */
    
    
    
    
    
    
}
