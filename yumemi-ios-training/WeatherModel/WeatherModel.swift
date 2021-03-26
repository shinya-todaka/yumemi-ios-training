//
//  WeatherModel.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/22.
//

/// @mockable
protocol WeatherModel: AnyObject {
    func fetchWeather(request: WeatherRequest, completion: @escaping (WeatherInfo?) -> Void)
}
