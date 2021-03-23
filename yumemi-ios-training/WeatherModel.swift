//
//  WeatherModel.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/22.
//

import Foundation

protocol WeatherModel {
    func fetchWeather(request: WeatherRequest) -> Result<WeatherInfo, FetchWeatherError>
}
