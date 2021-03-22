//
//  ViewController.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/15.
//

import UIKit
import YumemiWeather

final class WeatherViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    
    @IBAction func reloadWeatherAction(_ sender: Any) {
        reloadWeather()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func willEnterForeground() {
        reloadWeather()
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    private func reloadWeather() {
        let exampleRequest = WeatherRequest(area: "tokyo", date: Date())
        
        switch fetchWeather(request: exampleRequest) {
        case let .success(weatherInfo):
            configure(with: weatherInfo)
            
        case let .failure(error):
            showAlert(message: error.errorDescription)
        }
    }
    
    private func fetchWeather(request: WeatherRequest) -> Result<WeatherInfo, FetchWeatherError> {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        guard let requestData = try? encoder.encode(request),
              let jsonString = String(data: requestData, encoding: .utf8) else {
            return .failure(.encodeRequestError)
        }
        
        let jsonResponseString: String
        
        do {
            jsonResponseString = try YumemiWeather.fetchWeather(jsonString)
        } catch let error as YumemiWeatherError {
            return .failure(.apiError(error))
        } catch {
            return .failure(.unknownError)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let responseData = jsonResponseString.data(using: .utf8),
              let weatherInfo = try? decoder.decode(WeatherInfo.self, from: responseData) else {
            return .failure(.decodeResponseError)
        }
        
        return .success(weatherInfo)
    }
    
    private func configure(with weatherInfo: WeatherInfo) {
        maxTempLabel.text = "\(weatherInfo.maxTemp)"
        minTempLabel.text = "\(weatherInfo.minTemp)"
        let weather = weatherInfo.weather
        weatherImageView.image = weather.image
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

private extension Weather {
    var image: UIImage {
        switch self {
        case .sunny:
            return UIImage(named: "iconmonstr-weather-1")!.withTintColor(.systemRed)
            
        case .rainy:
            return UIImage(named: "iconmonstr-umbrella-1")!.withTintColor(.systemBlue)
            
        case .cloudy:
            return UIImage(named: "iconmonstr-weather-11")!.withTintColor(.systemGray)
        }
    }
}
