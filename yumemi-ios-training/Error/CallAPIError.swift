//
//  FetchWeatherError.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/18.
//

import Foundation

enum CallAPIError: Error {
    case encodeRequestError
    case apiError(errorMessage: String)
    case decodeResponseError
    case unknownError
    
    var errorDescription: String {
        switch self {
        case .encodeRequestError:
            return "リクエストのエンコードに失敗しました"
            
        case let .apiError(errorMessage):
            return errorMessage
            
        case .decodeResponseError:
            return "レスポンスのデコードに失敗しました"
      
        case .unknownError:
            return "不明なエラー"
        }
    }
}
