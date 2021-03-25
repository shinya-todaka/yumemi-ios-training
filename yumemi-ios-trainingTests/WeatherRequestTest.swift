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
    
    func test_JSONEncoding_WithFullData() throws {
        let date = Date()
        let dateString = Self.dateFormatter.string(from: date)
        
        let request = WeatherRequest(area: "tokyo", date: date)
        
        let expectedJson = """
        {
            "area": "tokyo",
            "date": "\(dateString)"
        }
        """
        
        testEncoding(object: request, encoder: Self.encoder, expectedJsonString: expectedJson)
    }
}
