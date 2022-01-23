//
//  WeatherDataModel.swift
//  WeatherApi
//
//  Created by Roman on 22.01.2022.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let id: Int
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let pressure: Double
    let temp_min: Double
    let temp_max: Double
    
    var tempInCelsius: String {
        String(format: "%.0f", round((temp - 32) * 5 / 9))
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    
    var systemIconNameString: String {
        switch id {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
}
