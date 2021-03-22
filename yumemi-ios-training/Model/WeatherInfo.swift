//
//  WeatherInfo.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/17.
//

import Foundation

struct WeatherInfo: Decodable {
    let weather: Weather
    let maxTemp: Int
    let minTemp: Int
    let date: Date
}
