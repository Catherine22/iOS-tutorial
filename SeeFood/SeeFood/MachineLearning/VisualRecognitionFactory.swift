//
//  VisualRecognitionFactory.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 27/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import Foundation

class VisualRecognitionFactory {
    enum Model {
        case Inceptionv3
        case WatsonVisualRecognition
    }
    
    func getModel(model: Model) -> VisualRecognitionDelegate {
        switch model {
        case .Inceptionv3:
            return Inceptionv3Model()
        case .WatsonVisualRecognition:
            return WatsonVisualRecognition()
        }
    }
}
