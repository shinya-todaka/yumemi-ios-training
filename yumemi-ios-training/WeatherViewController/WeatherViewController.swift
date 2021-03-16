//
//  ViewController.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/15.
//

import UIKit
import YumemiWeather

final class WeatherViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBAction func reloadWeatherAction(_ sender: Any) {
        reloadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func reloadWeather() {
        let weatherString = YumemiWeather.fetchWeather()
        
        let weather = Weather(rawValue: weatherString)!
        let weatherImage = UIImage(named: weather.imageName)!
        let coloredWeatherImage = weatherImage.withTintColor(weather.imageColor)
        weatherImageView.image = coloredWeatherImage
    }
}

private extension Weather {
    var imageName: String {
        switch self {
        case .sunny:
            return "iconmonstr-weather-1"
        case .rainy:
            return "iconmonstr-umbrella-1"
        case .cloudy:
            return "iconmonstr-weather-11"
        }
    }
    
    var imageColor: UIColor {
        switch self {
        case .sunny:
            return .systemRed
        case .rainy:
            return .systemBlue
        case .cloudy:
            return .systemGray
        }
    }
}
