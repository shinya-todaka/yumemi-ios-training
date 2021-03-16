//
//  Instantiatable.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/15.
//

import UIKit

public protocol Instantiatable: NSObjectProtocol {
    static func instantiate() -> Self 
}

public protocol StoryboardInstantiatable: UIViewController, Instantiatable { }

public extension StoryboardInstantiatable {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: className, bundle: Bundle(for: self))
    }

    static func instantiate() -> Self {
        return storyboard.instantiateInitialViewController() as! Self
    }
}
