//
//  WeatherInfoTest.swift
//  yumemi-ios-trainingTests
//
//  Created by 戸高 新也 on 2021/03/24.
//

import XCTest
import SnapshotTesting
@testable import yumemi_ios_training

class WeatherInfoTest: XCTestCase {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    func test_JSONParsing_WithPartialData() {
       let weatherInfo: WeatherInfo? = WeatherInfo.decodeJSONDictionary([
         "min_temp": 1
       ])

       XCTAssertNil(weatherInfo)
     }
    
    func test_JSONParsing_WithFullData_SwiftDecodable() {
        let json = """
        {
          "weather": "sunny",
          "max_temp": 28,
          "min_temp": 4,
          "date": "2020-04-01T12:00:00+09:00"
        }
        """
        
        let data = json.data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let weatherInfo = try? decoder.decode(WeatherInfo.self, from: data!)
        
        XCTAssertNotNil(weatherInfo)
        XCTAssertEqual(weatherInfo!.weather.rawValue, "sunny")
        XCTAssertEqual(weatherInfo!.maxTemp, 28)
        XCTAssertEqual(weatherInfo!.date, dateFormatter.date(from: "2020-04-01T12:00:00+09:00"))
    }
    
    func test_JSONParsing_WithIncorrectWeather_SwiftDecodable() {
        let json = """
        {
          "weather": "snowy",
          "max_temp": 28,
          "min_temp": 4,
          "date": "2020-04-01T12:00:00+09:00"
        }
        """
        
        let data = json.data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let weatherInfo = try? decoder.decode(WeatherInfo.self, from: data!)
        
        XCTAssertNil(weatherInfo)
    }
    
    func test_JSONParsing_WithIncorrectDate_SwiftDecodable() {
        let json = """
        {
          "weather": "snowy",
          "max_temp": 28,
          "min_temp": 4,
          "date": "2017/8/12"
        }
        """
        
        let data = json.data(using: .utf8)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let weatherInfo = try? decoder.decode(WeatherInfo.self, from: data!)
        
        XCTAssertNil(weatherInfo)
    }
}
