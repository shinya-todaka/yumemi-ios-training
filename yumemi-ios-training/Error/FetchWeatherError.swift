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
        case .apiError(.invalidParameterError):
            return "パラメータが正しくありません"
        case .apiError(.jsonDecodeError):
            return "JSONのデコードに失敗しました"
            
        case .unknownError, .apiError(.unknownError):
            return "不明なエラー"
        }
    }
}
