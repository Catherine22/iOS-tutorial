//
//  ViewController.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 13/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import CoreML

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
        self.navigationItem.title = ""
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
            imagePicker.dismiss(animated: true, completion: nil)
            
            let visualRecognitionFactory = VisualRecognitionFactory()
            var model = visualRecognitionFactory.getModel(model: VisualRecognitionFactory.Model.WatsonVisualRecognition) // or Inceptionv3
            model.delegate = self
            model.detect(uiimage: userPickedImage)
            
        }
        
    }
}

extension ViewController: DetectionDelegate {
    func onResult(isHotDog: Bool) {
        DispatchQueue.main.async {
            if isHotDog == true {
                self.navigationItem.title = "Hotdog!"
            } else {
                self.navigationItem.title = "Not Hotdog!"
            }
        }
    }
}
