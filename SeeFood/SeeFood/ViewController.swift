//
//  ViewController.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 13/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import CoreML
import SVProgressHUD
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var hotdogBackgroundImage: UIImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var hotdogImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
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
        
        hotdogImage.contentMode = .scaleAspectFit
        clearStyle()
    }
    
    func clearStyle() {
        topImageView.isHidden = true
        shareButton.isHidden = true
        hotdogBackgroundImage.isHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.yellow]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.barTintColor = nil
        self.navigationController?.navigationBar.isTranslucent = true
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        clearStyle()
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func onShareButtonPressed(_ sender: UIButton) {
        let image = UIImage(named: "hotdogBackground")
        let text = "My food is \(navigationItem.title!)"
        if #available(iOS 11, *) {
            // run on iOS 11+ devices
            let activityViewController = UIActivityViewController(activityItems: [image!, text], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        } else {
            // send a tweet
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                vc?.setInitialText(text)
                vc?.add(image)
                present(vc!, animated: true, completion: nil)
            } else {
                print("Please log in your twitter account")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            hotdogImage.image = userPickedImage
            imagePicker.dismiss(animated: true, completion: nil)
            SVProgressHUD.show()
            
            DispatchQueue.global(qos: .background).async {
                let visualRecognitionFactory = VisualRecognitionFactory()
                var model = visualRecognitionFactory.getModel(model: VisualRecognitionFactory.Model.WatsonVisualRecognition) // or Inceptionv3
                model.delegate = self
                model.detect(uiimage: userPickedImage)
            }
            
        }
        
    }
}

extension ViewController: DetectionDelegate {
    func onResult(isHotDog: Bool) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.topImageView.isHidden = false
            self.shareButton.isHidden = false
            self.hotdogBackgroundImage.isHidden = true
            if isHotDog == true {
                self.navigationItem.title = "Hotdog!"
                self.navigationController?.navigationBar.barTintColor = UIColor.green
                self.navigationController?.navigationBar.isTranslucent = false
                self.topImageView.image = UIImage(named: "hotdog")
            } else {
                self.navigationItem.title = "Not Hotdog!"
                self.navigationController?.navigationBar.barTintColor = UIColor.red
                self.navigationController?.navigationBar.isTranslucent = false
                self.topImageView.image = UIImage(named: "not-hotdog")
            }
        }
    }
}
