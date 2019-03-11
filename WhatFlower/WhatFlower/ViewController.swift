//
//  ViewController.swift
//  WhatFlower
//
//  Created by Catherine Chen (RD-TW) on 13/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import CoreML
import Vision
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&exintro=&explaintext=&indexpageids=&redirects=1&titles=gerbera%20jamesonii
    
    //https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&pithumbsize=500&titles=gerbera%20jamesonii
    
    let WIKI_URL = "https://en.wikipedia.org/w/api.php"
    
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var flowerDescTextView: UITextView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        flowerImage.contentMode = .scaleAspectFit
        navigationItem.title = "What Flower"
        flowerDescTextView.text = ""
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        navigationItem.title = "What Flower"
        flowerDescTextView.text = ""
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            flowerImage.image = userPickedImage
            imagePicker.dismiss(animated: true, completion: nil)
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Error converting UIImage to CIImage")
            }
            detect(ciimage: ciimage)
        }
        
    }
    
    func detect(ciimage: CIImage) {
        SVProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
                fatalError("Loading CoreML model failed")
            }
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("Model failed to process image")
                }
                
                if let firstResult = results.first { // get the most related result
                    self.queryWikiPedia(flowerName: firstResult.identifier)
                    return
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: ciimage)
            do {
                try handler.perform([request])
            } catch {
                fatalError("Error performing: \(error)")
            }
        }
    }
    
    func queryWikiPedia(flowerName: String) {
        let parameters: Parameters = [
            "action": "query",
            "format": "json",
            "prop": "extracts",
            "exintro": "",
            "explaintext": "",
            "indexpageids": "",
            "redirects": "1",
            "titles": flowerName
        ]
        
        Alamofire.request(WIKI_URL, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let flowerInfoJSON: JSON = JSON(response.result.value!)
                //                    print(flowerInfoJSON)
                var message = ""
                if let pageids = flowerInfoJSON["query"]["pageids"][0].string {
                    message = flowerInfoJSON["query"]["pages"][pageids]["extract"].string ?? ""
                }
                DispatchQueue.main.async {
                    self.flowerDescTextView.text = message
                    self.navigationItem.title = flowerName
                }
                self.queryThumbnail(flowerName: flowerName)
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    func queryThumbnail(flowerName: String) {
        let parameters: Parameters = [
            "action": "query",
            "format": "json",
            "exintro": "",
            "explaintext": "",
            "indexpageids": "",
            "redirects": "1",
            "titles": flowerName,
            "prop": "pageimages",
            "pithumbsize": "500"
        ]
        
        Alamofire.request(WIKI_URL, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                DispatchQueue.main.async {
                    let flowerInfoJSON: JSON = JSON(response.result.value!)
                    SVProgressHUD.dismiss()
                    guard let pageids = flowerInfoJSON["query"]["pageids"][0].string else {
                        return
                    }
                    guard let thumbnail = flowerInfoJSON["query"]["pages"][pageids]["thumbnail"]["source"].string else {
                        return
                    }
                    self.flowerImage.sd_setImage(with: URL(string: thumbnail))
                }
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }
}
