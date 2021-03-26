//
//  RootViewController.swift
//  yumemi-ios-training
//
//  Created by 戸高 新也 on 2021/03/19.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let weatherModelImpl = WeatherModelImpl()
        let scheduler = Scheduler()
        let dependency = WeatherViewController.Dependency(weatherModel: weatherModelImpl, scheduler: scheduler)
        
        let weatherViewController = WeatherViewController.instantiate(with: dependency)
        weatherViewController.modalPresentationStyle = .fullScreen
        present(weatherViewController, animated: true, completion: nil)
    }
}
