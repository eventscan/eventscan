//
//  CameraViewController.swift
//  EventScan
//
//  Created by Harshitha Bobba on 3/31/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController  {
    static var should_appear = false
    @IBOutlet weak var imageScreen: UIImageView!
    @IBOutlet weak var confirm_button: UIButton!
    @IBOutlet weak var clear_button: UIButton!
    
    override func viewDidLoad() {
        TakeAVPictureButton(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        confirm_button.isHidden = self.imageScreen.image == nil
        clear_button.isHidden = self.imageScreen.image == nil
        
        if (CameraViewController.should_appear && self.imageScreen.image == nil){
            TakeAVPictureButton(self)
        }
    }
    
    @IBAction func TakeAVPictureButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? UIImagePickerController.SourceType.camera : UIImagePickerController.SourceType.photoLibrary
        self.present(image, animated: true)
        
        CameraViewController.should_appear = false
    }
    
    @IBAction func confirm_button_clicked(_ sender: Any) {
        //tranfer data
        DetailViewController.fromParser = true
        tabBarController?.selectedIndex = 2
        clear_button_clicked(sender)
    }
    
    @IBAction func clear_button_clicked(_ sender: Any) {
        self.imageScreen.image = nil
        confirm_button.isHidden = self.imageScreen.image == nil
        clear_button.isHidden = self.imageScreen.image == nil
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

extension CameraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageScreen.image = image
        } else {
            print("Error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //     self.imageScreen.image = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
