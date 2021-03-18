//
//  YumemiWeatherError+errorDescription.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/18.
//

import YumemiWeather

extension YumemiWeatherError {
    var errorDescription: String {
        switch self {
        case .invalidParameterError:
            return "パラメータが正しくありません"
            
        case .jsonDecodeError:
            return "JSONのデコードに失敗しました"
            
        case .unknownError:
            return "不明なエラー"
        }
    }
}
