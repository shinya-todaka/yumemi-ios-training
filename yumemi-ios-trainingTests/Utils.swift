//
//  Utils.swift
//  yumemi-ios-trainingTests
//
//  Created by 戸高 新也 on 2021/03/25.
//

import XCTest
import Foundation

extension String {
    func jsonDictionary() throws -> [String: AnyHashable]? {
        let data = Data(utf8)
        return try data.jsonDictionary()
    }
}

extension Data {
    func jsonDictionary() throws -> [String: AnyHashable]? {
        return try JSONSerialization.jsonObject(with: self, options: []) as? [String: AnyHashable]
    }
}

func testDecoding<T: Decodable & Equatable>(expectedObject: T, decoder: JSONDecoder = JSONDecoder(), json: String) {
    do {
        let data = json.data(using: .utf8)
        XCTAssertNotNil(data)
        
        let object = try decoder.decode(T.self, from: data!)
        XCTAssertEqual(object, expectedObject)
    } catch {
        XCTFail("expected success decode")
    }
}

func testEncoding<T: Encodable>(object: T, encoder: JSONEncoder = JSONEncoder(), expectedJsonString: String) {
    do {
        let data = try encoder.encode(object)
        let requestDictionary = try data.jsonDictionary()
        let expected = try expectedJsonString.jsonDictionary()
        
        XCTAssertEqual(requestDictionary, expected)
    } catch {
        XCTFail("expected success encode")
    }
}

