//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

// WeatherViewController is a subclass of UIViewController and CLLocationManagerDelegate
class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let WEATHER_URL_PARAM_BY_CITY = "%@?q=%@"
    let APP_ID = "943e6e87148c5b34bfd538139bd0cf4e"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    var weatherDataModel: WeatherDataModel!
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In order to use CoreLocation library, inside that library there is a whole bunch of code with various of classes and methods that help us to do everything that is location related.
        
        // In order to use CLLocationManager and all of its capebilities, the WeatherViewController has to become a delegate of the CLLocationManager.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // Ask users for permission, go to info.plist or the pop-up won't appear
        locationManager.requestWhenInUseAuthorization()
        
        // Asynchronous method (It works in the background), call didUpdateLocations and didFailWithError methods to handle callbacks
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String: String]){
        // It makes a request in the background
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            // what should be triggered once the background processes has completed
            if response.result.isSuccess {
                print("Success! Got the weather data")
                
                let weatherJSON: JSON = JSON(response.result.value!)
//                print(weatherJSON)
                // When you see the 'in' key word, you are in a closure, a function inside a function,
                // you always have to specify 'self' in front of your methods
                self.updateWeatherData(json: weatherJSON)
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection issues"
            }
        }
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            let conditionResult = json["weather"][0]["id"].int!
            weatherDataModel = WeatherDataModel (
                temperature: Int(tempResult - 273.15),
                condition: conditionResult,
                city: json["name"].string!
            )
            updateUIWithWeatherData()
        } else if let errorMessage = json["message"].string {
            print("Error(\(json["cod"])): \(errorMessage)")
            cityLabel.text = "Weather unavailable"
        }
        else {
            cityLabel.text = "Weather unavailable"
        }
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)
        weatherIcon.image = UIImage(named: weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition))
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // the laster the more accurate
        let location = locations[locations.count - 1]
        // Accuracy means the spread of possible locations.
        // When that value is nagetive, that represents an invalid result
        if (location.horizontalAccuracy > 0) {
            // Unless you want to destroy users' battery, you should stop updating locations as soon as you get the valid data
            locationManager.stopUpdatingLocation()
            
            print("(\(location.coordinate.longitude), \(location.coordinate.latitude))")
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            let params:[String: String] = ["lon": longitude, "lat": latitude, "appid": APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location unavailable"
        print(error)
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


