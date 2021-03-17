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
    
    @IBAction func reloadWeatherAction(_ sender: Any) {
        reloadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func reloadWeather() {
        let exampleArea = "tokyo"
        
        do {
            let weather = try fetchWeather(at: exampleArea)
            self.weatherImageView.image = weather.image
        } catch let error as YumemiWeatherError {
            
            showAlert(message: error.errorDescription)
        } catch let error {
            
            showAlert(message: error.localizedDescription)
        }
    }
    
    private func fetchWeather(at area: String) throws -> Weather {
        let weatherString = try YumemiWeather.fetchWeather(at: area)
        let weather = Weather(rawValue: weatherString)!
        return weather
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

private extension YumemiWeatherError {
    var errorDescription: String {
        switch self {
        case .invalidParameterError:
            return "パラメータが正しくありません"
            
        case .jsonDecodeError:
            return "JSONのデコードに失敗しました"
            
        case .unknownError:
            return "不明なエラー"
        }
    }
}
