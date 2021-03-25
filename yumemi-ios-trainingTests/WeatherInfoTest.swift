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
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func test_JSONParsing_WithFullData_SwiftDecodable() throws {
        let json = """
        {
          "weather": "sunny",
          "max_temp": 28,
          "min_temp": 4,
          "date": "2020-04-01T12:00:00+09:00"
        }
        """
        
        let expectedDate = Self.dateFormatter.date(from: "2020-04-01T12:00:00+09:00")
        XCTAssertNotNil(expectedDate)
        
        let expected = WeatherInfo(weather: .sunny, maxTemp: 28, minTemp: 4, date: expectedDate!)
        testDecoding(expectedObject: expected, decoder: Self.decoder, json: json)
    }
    
    func test_JSONParsing_WithPartialData() {
       let json = """
        {
            "min_temp": 28
        }
        """
        
        let data = json.data(using: .utf8)
        XCTAssertNotNil(data)
        XCTAssertThrowsError(try Self.decoder.decode(WeatherInfo.self, from: data!))
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
        XCTAssertNotNil(data)
        
        XCTAssertThrowsError(try Self.decoder.decode(WeatherInfo.self, from: data!))
    }
    
    func test_JSONParsing_WithIncorrectDate_SwiftDecodable() {
        let json = """
        {
          "weather": "sunny",
          "max_temp": 28,
          "min_temp": 4,
          "date": "2017/8/12"
        }
        """
        
        let data = json.data(using: .utf8)
        XCTAssertNotNil(data)
        
        XCTAssertThrowsError(try Self.decoder.decode(WeatherInfo.self, from: data!))
    }
}
