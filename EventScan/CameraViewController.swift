//
//  CameraViewController.swift
//  EventScan
//
//  Created by Harshitha Bobba on 3/31/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var imageScreen: UIImageView!
    
    
    @IBAction func takeAPictureButton(_ sender: UIButton) {
        
    }
    
    // actions from AVFoundation library
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            let stillImgOutput = AVCapturePhotoOutput()
            let settings = AVCapturePhotoSettings()
            settings.livePhotoVideoCodecType = .jpeg
            stillImgOutput.capturePhoto(with: settings, delegate: self as! AVCapturePhotoCaptureDelegate)
            
            if session!.canAddOutput(stillImgOutput) {
                session!.addOutput(stillImgOutput)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspect
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                //videoPreviewLayer.addSublayer(videoPreviewLayer!)
                //session!.startRunning()
                
                
                
            }

            
            
            
            
        }
        
        

        // Do any additional setup after loading the view.
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
