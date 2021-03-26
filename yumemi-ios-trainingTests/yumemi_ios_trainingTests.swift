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

    func getwWeatherImage(viewController: UIViewController) -> UIImage? {
        let stackView = viewController.view.subviews
            .compactMap { $0 as? UIStackView }
            .first!

        let imageView = stackView.arrangedSubviews
            .compactMap { $0 as? UIImageView }
            .first!
        
        return imageView.image
    }
    
    func getTempLabel(viewController: UIViewController, accessibilityIdentifier: String) -> UILabel {
        let childStackView = viewController.view.subviews
            .compactMap { $0 as? UIStackView }
            .first!.arrangedSubviews
            .compactMap { $0 as? UIStackView }
            .first!
        
        let tempLabel = childStackView.arrangedSubviews
            .filter { $0.accessibilityIdentifier == accessibilityIdentifier }
            .first as! UILabel
        
        return tempLabel
    }
    
    func test_天気予報がsunnyだったら画面に晴れ画像が表示されること() throws {
        let weatherMock = WeatherModelMock()
        let sunnyResponse: WeatherInfo = .init(weather: .sunny, maxTemp: 99, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            weatherMock.delegate?.didChange(weatherInfo: sunnyResponse)
        }
        
        let testScheduler = TestScheduler()
        let viewController = WeatherViewController.instantiate(with: .init(weatherModel: weatherMock, scheduler: testScheduler))
        
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)

        let weatherImage = getwWeatherImage(viewController: viewController)
        let expectedImage = UIImage(named: "iconmonstr-weather-1")!.withTintColor(.systemRed)

        XCTAssertEqual(weatherImage, expectedImage)
    }
    
    func test_天気予報がcloudyだったら画面に曇り画像が表示されること() throws {
        let weatherMock = WeatherModelMock()
        let cloudyResponse: WeatherInfo = .init(weather: .cloudy, maxTemp: 99, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            weatherMock.delegate?.didChange(weatherInfo: cloudyResponse)
        }
        
        let testScheduler = TestScheduler()
        let viewController = WeatherViewController.instantiate(with: .init(weatherModel: weatherMock, scheduler: testScheduler))
        
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)

        let weatherImage = getwWeatherImage(viewController: viewController)
        let expectedImage = UIImage(named: "iconmonstr-weather-11")!.withTintColor(.systemGray)
        
        XCTAssertEqual(weatherImage, expectedImage)
    }
    
    func test_天気予報がrainyだったら画面に雨画像が表示されること() throws {
        let weatherMock = WeatherModelMock()
        let rainyResponse: WeatherInfo = .init(weather: .rainy, maxTemp: 99, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            weatherMock.delegate?.didChange(weatherInfo: rainyResponse)
        }
        
        let testScheduler = TestScheduler()
        let viewController = WeatherViewController.instantiate(with: .init(weatherModel: weatherMock, scheduler: testScheduler))
        
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
    
        let weatherImage = getwWeatherImage(viewController: viewController)
        let expectedImage = UIImage(named: "iconmonstr-umbrella-1")!.withTintColor(.systemBlue)
        
        XCTAssertEqual(weatherImage, expectedImage)
    }
    
    func test_天気予報の最高気温がUILabelに反映されること() throws {
        let weatherMock = WeatherModelMock()
        let rainyResponse: WeatherInfo = .init(weather: .rainy, maxTemp: 45, minTemp: -99, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            weatherMock.delegate?.didChange(weatherInfo: rainyResponse)
        }
        
        let testScheduler = TestScheduler()
        let viewController = WeatherViewController.instantiate(with: .init(weatherModel: weatherMock, scheduler: testScheduler))
        
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)
        
        let maxTempLabel = getTempLabel(viewController: viewController, accessibilityIdentifier: "maxTempLabel")
        XCTAssertEqual(maxTempLabel.text, "\(rainyResponse.maxTemp)")
    }
    
    func test_天気予報の最低気温がUILabelに反映されること() throws {
        let weatherMock = WeatherModelMock()
        let rainyResponse: WeatherInfo = .init(weather: .rainy, maxTemp: 99, minTemp: -45, date: Date())
        
        weatherMock.fetchWeatherHandler = { _ in
            weatherMock.delegate?.didChange(weatherInfo: rainyResponse)
        }
        
        let testScheduler = TestScheduler()
        let viewController = WeatherViewController.instantiate(with: .init(weatherModel: weatherMock, scheduler: testScheduler))
        
        viewController.loadViewIfNeeded()
        viewController.viewDidAppear(true)

        let minTempLabel = getTempLabel(viewController: viewController, accessibilityIdentifier: "minTempLabel")
        XCTAssertEqual(minTempLabel.text, "\(rainyResponse.minTemp)")
    }
}
