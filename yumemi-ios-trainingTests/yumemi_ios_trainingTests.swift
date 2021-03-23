//
//  yumemi_ios_trainingTests.swift
//  yumemi-ios-trainingTests
//
//  Created by 戸高 新也 on 2021/03/15.
//

import XCTest
import SnapshotTesting
@testable import yumemi_ios_training

class yumemi_ios_trainingTests: XCTestCase {

    func test_天気予報がsunnyだったら画面に晴れ画像が表示されること() throws {
        
        let weatherMock = WeatherModelMock()
        
        let sunnyResponse: WeatherInfo = .init(weather: .sunny, maxTemp: 99, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            return .success(sunnyResponse)
        }
        
        let viewController = WeatherViewController.instantiate(with: weatherMock)
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
        
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func test_天気予報がcloudyだったら画面に曇り画像が表示されること() throws {
        
        let weatherMock = WeatherModelMock()
        
        let cloudyResponse: WeatherInfo = .init(weather: .cloudy, maxTemp: 99, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            return .success(cloudyResponse)
        }
        
        let viewController = WeatherViewController.instantiate(with: weatherMock)
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
        
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func test_天気予報がrainyだったら画面に雨画像が表示されること() throws {
        
        let weatherMock = WeatherModelMock()
        
        let rainyResponse: WeatherInfo = .init(weather: .rainy, maxTemp: 99, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            return .success(rainyResponse)
        }
        
        let viewController = WeatherViewController.instantiate(with: weatherMock)
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
        
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func test_天気予報の最高気温がUILabelに反映されること() throws {
        let weatherMock = WeatherModelMock()
        
        let rainyResponse: WeatherInfo = .init(weather: .rainy, maxTemp: 45, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            return .success(rainyResponse)
        }
        
        let viewController = WeatherViewController.instantiate(with: weatherMock)
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
        
        let childStackView = viewController.view.subviews
            .compactMap { $0 as? UIStackView }
            .first!.arrangedSubviews
            .compactMap { $0 as? UIStackView }
            .first!
        
        let maxTempLabel = childStackView.arrangedSubviews
            .filter { $0.accessibilityIdentifier == "maxTempLabel" }
            .first as! UILabel
        
        XCTAssertEqual(maxTempLabel.text, "\(rainyResponse.maxTemp)")
    }
    
    func test_天気予報の最低気温がUILabelに反映されること() throws {
        let weatherMock = WeatherModelMock()
        
        let rainyResponse: WeatherInfo = .init(weather: .rainy, maxTemp: 99, minTemp: -45, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            return .success(rainyResponse)
        }
        
        let viewController = WeatherViewController.instantiate(with: weatherMock)
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
        
        let childStackView = viewController.view.subviews
            .compactMap { $0 as? UIStackView }
            .first!.arrangedSubviews
            .compactMap { $0 as? UIStackView }
            .first!
        
        let minTempLabel = childStackView.arrangedSubviews
            .filter { $0.accessibilityIdentifier == "minTempLabel" }
            .first as! UILabel
        
        XCTAssertEqual(minTempLabel.text, "\(rainyResponse.minTemp)")
    }
}
