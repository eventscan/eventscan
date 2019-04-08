//
//  CameraViewController.swift
//  EventScan
//
//  Created by Harshitha Bobba on 3/31/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    @IBOutlet weak var imageScreen: UIImageView!
    
    override func viewDidLoad() {
        TakeAVPictureButton(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if (UserDefaults.standard.bool(forKey: "view_diff") == nil || UserDefaults.standard.bool(forKey: "view_diff") == true) {
            TakeAVPictureButton(self)
        }
    }
    
    
    @IBAction func TakeAVPictureButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        self.present(image, animated: true)
        
        UserDefaults.standard.set(false, forKey: "view_diff")
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageScreen.image = image
            
            
            VisionHelper.parseTextFrom(image: image) { (text) in
                guard let text = text else {
                    AlertControllerHelper.presentAlert(for: self, withTitle: "Error!", withMessage: "Could not parse image!")
                    return
                }
                AlertControllerHelper.presentAlert(for: self, withTitle: "Parsed text!", withMessage: "Text:\n" + text)
            }
            
        } else {
            print("Error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
