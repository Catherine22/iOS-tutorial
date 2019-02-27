//
//  VisualRecognitionDelegate.swift
//  SeeFood
//
//  Created by Catherine Chen (RD-TW) on 27/02/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit

protocol VisualRecognitionDelegate {
    var delegate: DetectionDelegate? { get set }
    func detect(uiimage: UIImage)
}
