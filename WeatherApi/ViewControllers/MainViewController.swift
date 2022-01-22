//
//  ViewController.swift
//  WeatherApi
//
//  Created by Roman on 22.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet var cityLbel: UILabel!
    
    var weather: CurrentWeatherData!
    var newWeather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchData()
    }

    
    
    
    @IBAction func searchPressedButton(_ sender: Any) {
        
    }
    
    
    
    func updateInteface(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLbel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsTemperatureString
            self.weatherImage.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
    

    func fetchData() {
        NetworkManager.shared.fetch(dataType: CurrentWeatherData.self, from: "https://api.openweathermap.org/data/2.5/weather?q=London&apikey=31febb91c365c99e1c2dd2cb05e33f70") { result in
            switch result {
                
            case .success(let currentData):
                self.weather = currentData
                
            case .failure( let error):
                print(error.localizedDescription)
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


