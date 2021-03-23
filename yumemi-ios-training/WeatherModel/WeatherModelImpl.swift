//
//  WeatherModelImpl.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/22.
//

import Foundation
import YumemiWeather

class WeatherModelImpl: WeatherModel {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    func fetchWeather(request: WeatherRequest) -> Result<WeatherInfo, FetchWeatherError> {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        guard let requestData = try? encoder.encode(request),
              let jsonString = String(data: requestData, encoding: .utf8) else {
            return .failure(.encodeRequestError)
        }
        
        let jsonResponseString: String
        
        do {
            jsonResponseString = try YumemiWeather.fetchWeather(jsonString)
        } catch let error as YumemiWeatherError {
            return .failure(.apiError(error))
        } catch {
            return .failure(.unknownError)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let responseData = jsonResponseString.data(using: .utf8),
              let weatherInfo = try? decoder.decode(WeatherInfo.self, from: responseData) else {
            return .failure(.decodeResponseError)
        }
        
        return .success(weatherInfo)
    }
    
}
