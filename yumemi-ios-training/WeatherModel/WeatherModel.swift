//
//  WeatherModel.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/22.
//

/// @mockable
protocol WeatherModel: AnyObject {
    var delegate: WeatherModelDelegate? { get set }
    func fetchWeather(request: WeatherRequest)
}


