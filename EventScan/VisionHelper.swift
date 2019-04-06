//
//  ViewController.swift
//  EventScan
//
//  Created by Abid Amirali on 4/3/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMLCommon

struct VisionHelpe {
    
    static func parseTextFrom(image: UIImage) -> String? {
        super.viewDidLoad()
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        let visionImage = VisionImage(image: image!)
        
        textRecognizer.process(visionImage) { result, error in
            guard error == nil, let result = result else {
                // ...
                print(error?.localizedDescription)
                return nil
            }
            
            // Recognized text
            let resultText = result.text
            print(result.text)
            return result.text
        }
    }
    
    
}

