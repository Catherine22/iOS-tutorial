//
//  Inceptionv3Model.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 27/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import Vision

class Inceptionv3Model: VisualRecognitionDelegate {
    var delegate: DetectionDelegate?
    
    func detect(uiimage: UIImage) {
        guard let ciimage = CIImage(image: uiimage) else {
            fatalError("Error converting UIImage to CIImage")
        }
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            //            print(results)
            if let firstResult = results.first { // get the most related result
                print("This might be \(firstResult.identifier)")
                self.delegate?.onResult(isHotDog: firstResult.identifier.contains("hotdog"))
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
