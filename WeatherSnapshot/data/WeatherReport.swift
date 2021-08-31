//
//  WeatherReport.swift
//  WeatherSnapshot
//
//  Created by Austin Becton on 8/26/21.
//

import Foundation

class WeatherReport {
    
    
    var location: WeatherReportItem
    
    var currentTemp: WeatherReportItem
    var currentHighTemp: WeatherReportItem
    var currentLowTemp: WeatherReportItem
    var currentHumidity: WeatherReportItem
    var currentCondition: WeatherReportItem
    
    var tomorrowHighTemp: WeatherReportItem
    var tomorrowLowTemp: WeatherReportItem
    var tomorrowHumidity: WeatherReportItem
    var tomorrowCondition: WeatherReportItem
    
    init() {
                
        self.location = WeatherReportItem()
        self.currentTemp = WeatherReportItem()
        self.currentHighTemp = WeatherReportItem()
        self.currentLowTemp = WeatherReportItem()
        self.currentHumidity = WeatherReportItem()
        self.currentCondition = WeatherReportItem()
        self.tomorrowHighTemp = WeatherReportItem()
        self.tomorrowLowTemp = WeatherReportItem()
        self.tomorrowHumidity = WeatherReportItem()
        self.tomorrowCondition = WeatherReportItem()
        
        
        //FOR TESTING
        
        let exampleData_string = """
        {
            "city": "Dayton",
            "region": "Ohio",
            "country": "USA",
            "currentTemp": "90",
            "currentHighTemp": "91",
            "currentLowTemp": "79",
            "currentHumidity": "80",
            "currentCondition": "Sun",
            "tomorrowHighTemp": "85",
            "tomorrowLowTemp": "75",
            "tomorrowHumidity": "82",
            "tomorrowCondition": "Rain",
        }
        """
            
        let exampleData = exampleData_string.data(using: .utf8)!
        
        var dummyWeatherSnap: WeatherSnap
        let jsonDecoder = JSONDecoder()
        
        do {
            dummyWeatherSnap = try jsonDecoder.decode(WeatherSnap.self, from: exampleData)
            //FOR TESTING:
            convertSnapToReport(newData: dummyWeatherSnap)
        } catch {
            print("error attempting JSON decode")

        }
    
        //REAL ONE: convertSnapToReport(newData: data)
        
    }
    
    func provideWeatherItems() -> [WeatherReportItem] {
        var newArray: [WeatherReportItem] = [WeatherReportItem]()
        newArray.append(location)
        newArray.append(currentTemp)
        newArray.append(currentHighTemp)
        newArray.append(currentLowTemp)
        newArray.append(currentHumidity)
        newArray.append(currentCondition)
        newArray.append(tomorrowHighTemp)
        newArray.append(tomorrowLowTemp)
        newArray.append(tomorrowHumidity)
        newArray.append(tomorrowCondition)
        return newArray
    }
    
    
    func convertSnapToReport (newData: WeatherSnap) -> Void {
        
        print("Converting snap to report in WeatherReport class")
        self.location.type = .location
        if (newData.region.isEmpty) {
            self.location.data = newData.city + ", " + newData.country
        } else {
            self.location.data = newData.city + ", " + newData.region + ", " + newData.country
        }
        
        self.currentTemp.type = .currenttemp
        self.currentTemp.data = newData.currentTemp
        
        self.currentHighTemp.type = .currentHighTemp
        self.currentHighTemp.data = newData.currentHighTemp
        
        self.currentLowTemp.type = .currentLowTemp
        self.currentLowTemp.data = newData.currentLowTemp
        
        self.currentHumidity.type = .currentHumidity
        self.currentHumidity.data = newData.currentHumidity
        
        self.currentCondition.type = .currentCondition
        self.currentCondition.data = newData.currentCondition
        
        self.tomorrowHighTemp.type = .tomorrowHigh
        self.tomorrowHighTemp.data = newData.tomorrowHighTemp
        
        self.tomorrowLowTemp.type = .tomorrowLow
        self.tomorrowLowTemp.data = newData.tomorrowLowTemp
        
        self.tomorrowHumidity.type = .tomorrowHumidity
        self.tomorrowHumidity.data = newData.tomorrowHumidity
        
        self.tomorrowCondition.type = .tomorrowCondition
        self.tomorrowCondition.data = newData.tomorrowCondition
        
    }
    
    
    
    
    
}
