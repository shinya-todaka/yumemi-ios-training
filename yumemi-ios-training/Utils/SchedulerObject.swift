//
//  SchedulerObject.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/26.
//

import Foundation

protocol SchedulerObject {
    func runOnMainThread(_ block: @escaping () -> Void)
}

final class Scheduler: SchedulerObject {
    func runOnMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async { block() }
    }
}
