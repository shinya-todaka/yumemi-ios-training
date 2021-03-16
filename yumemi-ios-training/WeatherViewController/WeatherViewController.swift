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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        reloadButton.addTarget(self, action: #selector(handleReloadWeather), for: .touchUpInside)
    }
    
    @objc private func handleReloadWeather() {
        let weatherString = YumemiWeather.fetchWeather()
        
        let weather = Weather(rawValue: weatherString)!
        let weatherImage = UIImage(named: weather.imageName)!
        let coloredWeatherImage = weatherImage.withTintColor(weather.imageColor)
        weatherImageView.image = coloredWeatherImage
    }
}

