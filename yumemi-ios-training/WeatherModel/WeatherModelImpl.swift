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
    weak var delegate: WeatherModelDelegate?
    
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

    func fetchWeather(request: WeatherRequest){
        guard let requestData = try? encoder.encode(request),
              let jsonString = String(data: requestData, encoding: .utf8) else {
            delegate?.didChange(weatherInfo: nil)
            return
        }
        
        queue.async { [weak self] in
            guard let self = self else { return }
            
            guard let jsonResponseString = try? YumemiWeather.syncFetchWeather(jsonString) else {
                self.delegate?.didChange(weatherInfo: nil)
                return
            }
            
            guard let responseData = jsonResponseString.data(using: .utf8),
                  let weatherInfo = try? self.decoder.decode(WeatherInfo.self, from: responseData) else {
                self.delegate?.didChange(weatherInfo: nil)
                return
            }
            self.delegate?.didChange(weatherInfo: weatherInfo)
        }
    }
}
