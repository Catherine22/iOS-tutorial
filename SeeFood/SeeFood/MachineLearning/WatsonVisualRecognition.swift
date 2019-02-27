//
//  WatsonVisualRecognition.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 27/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import VisualRecognitionV3

class WatsonVisualRecognition: VisualRecognitionDelegate {
    var delegate: DetectionDelegate?
    private let API_KEY = "6w7q6lTas-zNm1cytoIvCYndxF5kf0VMQ5WZoaylJbta"
    private let VERSION = "2018-03-19"
    private var classificationResults: [String] = []
    
    func detect(uiimage: UIImage) {
//        let imageData = uiimage.jpegData(compressionQuality: 0.01)
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = documentsURL.appendingPathComponent("temp.jpg")
//
//        do {
//            try imageData?.write(to: fileURL)
//        } catch {
//            fatalError("Error writting image \(error)")
//        }
        
        
        let visualRecognition = VisualRecognition(version: VERSION, apiKey: API_KEY)
        visualRecognition.classify(image: uiimage) { (classifiedImages, error) in
            if let e = error {
                fatalError("Error \(e)")
            }
            
//            print(classifiedImages)
            
            if let classes = classifiedImages?.result?.images.first?.classifiers.first?.classes {
                for index in 0..<classes.count {
                    self.classificationResults.append(classes[index].className)
                }
                print(self.classificationResults)
                
                var found = false
                self.classificationResults.forEach({ (result) in
                    if result.contains("hotdog") {
                        self.delegate?.onResult(isHotDog: true)
                        found = true
                    }
                })
                if !found {
                    self.delegate?.onResult(isHotDog: false)
                }
            }
        }
    }
}

