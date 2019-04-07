//
//  ViewController.swift
//  EventScan
//
//  Created by 이승헌 on 18/03/2019.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

/*import UIKit
 
 class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 
 @IBOutlet weak var imageScreen: UIImageView!
 
 override func viewDidLoad() {
 
 }
 
 @IBAction func takeAPictureButton(_ sender: UIButton) {
 let image = UIImagePickerController()
 image.delegate = self
 image.sourceType = UIImagePickerController.SourceType.camera
 self.present(image, animated: true)
 }
 
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
 imageScreen.image = image
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
 
 } */
