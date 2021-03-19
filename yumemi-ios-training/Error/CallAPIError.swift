//
//  FetchWeatherError.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/18.
//

import Foundation

enum CallAPIError: Error {
    case apiError(errorMessage: String)
    case unknownError
    
    var errorDescription: String {
        switch self {
        case let .apiError(errorMessage):
            return errorMessage
            
        case .unknownError:
            return "不明なエラー"
        }
    }
}
