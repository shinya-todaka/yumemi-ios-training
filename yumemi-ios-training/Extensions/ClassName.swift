//
//  ClassName.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/15.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
