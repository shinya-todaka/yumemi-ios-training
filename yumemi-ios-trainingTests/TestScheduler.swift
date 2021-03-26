//
//  TestScheduler.swift
//  yumemi-ios-trainingTests
//
//  Created by 戸高 新也 on 2021/03/26.
//

@testable import yumemi_ios_training

final class TestScheduler: SchedulerObject {
    func runOnMainThread(_ block: @escaping () -> Void) {
        block()
    }
}
