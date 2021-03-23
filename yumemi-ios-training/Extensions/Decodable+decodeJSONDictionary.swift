//
//  Decodable+decodeJSONDictionary.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/24.
//

import Foundation

public extension Decodable {
    static func decodeJSONDictionary(_ json: Any) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let value = try JSONDecoder().decode(Self.self, from: data)
        return value
    }

    static func decodeJSONDictionary(_ json: Any) -> Self? {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []),
           let value = try? JSONDecoder().decode(Self.self, from: data) {
            return value
        }
        return nil
    }
}
