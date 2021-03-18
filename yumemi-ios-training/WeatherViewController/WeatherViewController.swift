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
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBAction func reloadWeatherAction(_ sender: Any) {
        reloadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func reloadWeather() {
        let exampleJson = """
            {"area": "tokyo", "date": "2020-04-01T12:00:00+09:00"}
            """

        do {
            let weatherInfo = try fetchWeather(jsonString: exampleJson)
            configure(with: weatherInfo)
        } catch let error as FetchWeatherError {
            showAlert(message: error.errorDescription)
        } catch let error {
            showAlert(message: error.localizedDescription)
        }
    }
    
    private func fetchWeather(jsonString: String) throws -> WeatherInfo {
        let jsonResponseString = try YumemiWeather.fetchWeather(jsonString)
        
        guard let data = jsonResponseString.data(using: .utf8),
              let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
              let dictionary = jsonResponse as? [String: Any],
              let weatherInfo = WeatherInfo(dictionary: dictionary) else {
            throw FetchWeatherError.decodeResponseError
        }
        return weatherInfo
    }
    
    private func configure(with weatherInfo: WeatherInfo) {
        self.maxTempLabel.text = "\(weatherInfo.maxTemp)"
        self.minTempLabel.text = "\(weatherInfo.minTemp)"
        let weather = weatherInfo.weather
        self.weatherImageView.image = weather.image
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
