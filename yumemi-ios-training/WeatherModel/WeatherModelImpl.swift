//
//  WeatherModelImpl.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/22.
//

import Foundation
import YumemiWeather

final class WeatherModelImpl: WeatherModel {
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchWeather(request: WeatherRequest, completion: @escaping (WeatherInfo?) -> Void){
        
        guard let requestData = try? encoder.encode(request),
              let jsonString = String(data: requestData, encoding: .utf8) else {
            completion(nil)
            return 
        }
        
        queue.async { [weak self] in
            do {
                let jsonResponseString = try YumemiWeather.syncFetchWeather(jsonString)
            
                guard let responseData = jsonResponseString.data(using: .utf8),
                    let weatherInfo = try? self?.decoder.decode(WeatherInfo.self, from: responseData) else {
                    completion(nil)
                    return
                }
                completion(weatherInfo)
            } catch {
                completion(nil)
            }
        }
    }
}
