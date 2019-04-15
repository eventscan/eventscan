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
        var image = image
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        if image.imageOrientation != .down {
            image = fixOrientation(img: image)
        }
        let visionImage = VisionImage(image: image)
        
        textRecognizer.process(visionImage) { result, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            guard let result = result else {
                completion(nil)
                return
            }
            
            // Recognized text
//            print(result.text)
            completion(result.text)
        }
    }
    
    static func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    
}

