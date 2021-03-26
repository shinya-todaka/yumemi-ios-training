//
//  WeatherModelDelegate.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/24.
//

protocol WeatherModelDelegate: AnyObject {
    func didChange(weatherInfo: WeatherInfo?)
}
