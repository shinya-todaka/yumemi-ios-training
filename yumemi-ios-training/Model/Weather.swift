//
//  Weather.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/15.
//

import UIKit

enum Weather: String {
    case sunny
    case rainy
    case cloudy
    
    var imageName: String {
        switch self {
        case .sunny:
            return "iconmonstr-weather-1"
        case .rainy:
            return "iconmonstr-umbrella-1"
        case .cloudy:
            return "iconmonstr-weather-11"
        }
    }
    
    var imageColor: UIColor {
        switch self {
        case .sunny:
            return .systemRed
        case .rainy:
            return .systemBlue
        case .cloudy:
            return .systemGray
        }
    }
}
