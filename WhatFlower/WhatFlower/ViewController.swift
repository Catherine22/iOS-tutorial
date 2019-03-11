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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var flowerImage: UIImageView!
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
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        navigationItem.title = "What Flower"
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
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            //            print(results)
            if let firstResult = results.first { // get the most related result
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Result", message: "This might be a(n) \(firstResult.identifier)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationItem.title = firstResult.identifier
                }))
                self.present(alert, animated: true, completion: nil)
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
