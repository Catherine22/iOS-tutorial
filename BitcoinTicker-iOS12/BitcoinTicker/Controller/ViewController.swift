//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currency = -1

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    //First, add the method numberOfComponents(in:) to determine how many columns we want in our picker.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Next, we need to tell Xcode how many rows this picker should have using the pickerView(numberOfRowsInComponent:) method.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    // Finally, let’s fill the picker row titles with the Strings from our currencyArray using the pickerView:titleForRow: method.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    // This will get called every time the picker is scrolled. When that happens it will record the row that was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        let finalURL = baseURL + currencyArray[row]
        getPriceData(url: finalURL)
    }
    
    

    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getPriceData(url: String/*, parameters: [String : String]*/) {
        
        Alamofire.request(url, method: .get/*, parameters: parameters*/)
            .responseJSON { (response) in
                if response.result.isSuccess {
                    print("Sucess! Got the price data")
                    let priceJSON: JSON = JSON(response.result.value!)
                    self.updatePriceData(json: priceJSON)
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
    }

    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updatePriceData(json : JSON) {
        if let lastPriceResult = json["last"].double {
            print(lastPriceResult)
            bitcoinPriceLabel.text = "\(symbolArray[currency]) \(String(lastPriceResult))"
        }
    }
    




}

