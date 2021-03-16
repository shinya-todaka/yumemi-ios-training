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
            let weatherString = try YumemiWeather.fetchWeather(at: exampleArea)
            let weather = Weather(rawValue: weatherString)!
            self.weatherImageView.image = weather.image
        } catch let error {
            let yumemiWeatherError = error as! YumemiWeatherError
        }
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
