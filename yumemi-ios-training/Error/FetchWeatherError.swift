//
//  FetchWeatherError.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/18.
//

import Foundation
import YumemiWeather

enum FetchWeatherError: Error {
    case apiError(YumemiWeatherError)
    case unknownError
    
    var errorDescription: String {
        switch self {
        case let .apiError(yumemiWeatherError):
            return yumemiWeatherError.errorDescription
        case .unknownError:
            return "不明なエラー"
        }
    }
}
