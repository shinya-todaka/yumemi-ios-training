//
//  ViewController.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/15.
//

import UIKit
import YumemiWeather

final class WeatherViewController: UIViewController, StoryboardInstantiatable, Injectable {
    
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var weatherModel: WeatherModel!
    private var scheduler: SchedulerObject!
    
    struct Dependency {
        let weatherModel: WeatherModel
        let scheduler: SchedulerObject
    }
    
    init?(coder: NSCoder, with dependency: Dependency) {
         weatherModel = dependency.weatherModel
         scheduler = dependency.scheduler
         super.init(coder: coder)
     }

     required init?(coder: NSCoder) {
         fatalError("You must create this view controller with a user.")
     }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadWeather), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func reloadWeather() {
        let exampleRequest = WeatherRequest(area: "tokyo", date: Date())
        
        loadingIndicator.startAnimating()
        weatherModel.fetchWeather(request: exampleRequest) { [weak self] weatherInfo in
            
            self?.scheduler.runOnMainThread { 
                self?.loadingIndicator.stopAnimating()
            
                if let weahterInfo = weatherInfo {
                    self?.configure(with: weahterInfo)
                } else {
                    self?.showAlert(message: "データの取得に失敗しました")
                }
            }
        }
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
