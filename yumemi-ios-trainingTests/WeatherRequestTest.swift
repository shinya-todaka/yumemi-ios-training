//
//  WeatherRequestTest.swift
//  yumemi-ios-trainingTests
//
//  Created by 戸高 新也 on 2021/03/24.
//

import XCTest
import SnapshotTesting
@testable import yumemi_ios_training

class WeatherRequestTest: XCTestCase {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    func test_JSONEncoding_WithFullData() {
        let date = Date()
        let request = WeatherRequest(area: "tokyo", date: date)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        let weatherRequestData = try! encoder.encode(request)
        let weatherRequestJson = try! JSONSerialization.jsonObject(with: weatherRequestData, options: .mutableContainers)
        
        let weatherRequestDictionary = weatherRequestJson as! [String: Any]
        
        XCTAssertEqual(weatherRequestDictionary["area"] as? String, "tokyo")
        XCTAssertEqual(weatherRequestDictionary["date"] as? String, dateFormatter.string(from: date))
    }
}
