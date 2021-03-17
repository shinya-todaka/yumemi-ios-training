//
//  WeatherInfo.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/17.
//

import Foundation

struct WeatherInfo {
    let weather: Weather
    let maxTemp: Int
    let minTemp: Int
    let date: String
    
    init?(dictionary: [String: Any]) {
        guard let weatherString = dictionary["weather"] as? String,
              let maxTemp = dictionary["max_temp"] as? Int,
              let minTemp = dictionary["min_temp"] as? Int,
              let date = dictionary["date"] as? String else {
            return nil
        }
        
        self.weather = Weather(rawValue: weatherString)!
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.date = date
    }
}
