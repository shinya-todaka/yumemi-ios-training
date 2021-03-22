//
//  WeatherRequest.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/19.
//

import Foundation

struct WeatherRequest: Encodable {
    let area: String
    let date: Date
}
