//
//  WeatherModelImpl.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/22.
//

import Foundation
import YumemiWeather

final class WeatherModelImpl: WeatherModel {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchWeather(request: WeatherRequest) -> Result<WeatherInfo, FetchWeatherError> {
        
        guard let requestData = try? Self.encoder.encode(request),
              let jsonString = String(data: requestData, encoding: .utf8) else {
            return .failure(.encodeRequestError)
        }
        
        let jsonResponseString: String
        
        do {
            jsonResponseString = try YumemiWeather.fetchWeather(jsonString)
            
            guard let responseData = jsonResponseString.data(using: .utf8) else {
                return .failure(.unknownError)
            }
            
            let weatherInfo = try Self.decoder.decode(WeatherInfo.self, from: responseData)
            
            return .success(weatherInfo)
            
        } catch let error as YumemiWeatherError {
            return .failure(.apiError(error))
        } catch {
            return .failure(.decodeResponseError)
        }
    }
}
