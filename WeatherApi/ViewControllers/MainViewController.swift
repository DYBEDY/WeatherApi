//
//  ViewController.swift
//  WeatherApi
//
//  Created by Roman on 22.01.2022.
//

import UIKit

struct Link {
    static let weatherURL = "https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1"
}

class MainViewController: UIViewController {
    
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    @IBAction func searchPressedButton(_ sender: Any) {
       
        }
    }


// MARK: Private Methods
extension MainViewController {
    private func setInterface(weatherData: WeatherData) {
        cityLabel.text = weatherData.name
        temperatureLabel.text = weatherData.main.tempInCelsius
        weatherImage.image = UIImage(
            systemName: weatherData.weather.first?.systemIconNameString ?? "nosign"
        )
        weatherLabel.text = weatherData.weather.first?.main ?? "No data"
    }
}

// MARK: Networking
extension MainViewController {
    func fetchData() {
        NetworkManager.shared.fetch(dataType: WeatherData.self, from: Link.weatherURL) { result in
            switch result {
            case .success(let weatherData):
                self.setInterface(weatherData: weatherData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Alert method
extension MainViewController {
    func showSearchAlertController(withTitle titlte: String?, message: String?, style: UIAlertController.Style, completion: @escaping(String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { textField in
            let cities = ["Moscow", "New York", "Viena", "Chicago"]
            textField.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completion(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        
    }
    
}


