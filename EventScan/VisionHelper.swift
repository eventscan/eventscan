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

struct VisionHelper {
    
    static func parseTextFrom(image: UIImage, completion: @escaping (String?) -> Void) {
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        let visionImage = VisionImage(image: image)
        
        textRecognizer.process(visionImage) { result, error in
            guard error == nil, let result = result else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            // Recognized text
            print(result.text)
            completion(result.text)
        }
    }
    
    
}

