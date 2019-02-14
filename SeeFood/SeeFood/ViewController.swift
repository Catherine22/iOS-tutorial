//
//  ViewController.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 13/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
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
        
        imageView.contentMode = .scaleAspectFit
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Error converting UIImage to CIImage")
            }
            
            detect(ciimage: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(ciimage: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
//            print(results)
            if let firstResult = results.first {
                print("This might be \(firstResult.identifier)")
                if (firstResult.identifier.contains("hotdog")) {
                    self.navigationItem.title = "Hotdog!"
                } else {
                    self.navigationItem.title = "Not Hotdog!"
                }
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

