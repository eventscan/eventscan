//
//  ViewController.swift
//  EventScan
//
//  Created by Abid Amirali on 3/25/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit


class ABBYHelper: NSObject {

    let applicationID = String("event_scanner")
    let password = String("iJnEI5SnzPugHYSH9oSrxV7c")
    var completion: ((String?) -> Void)?

    func parse(image: UIImage) {
        let image = UIImage(named: "image6.jpg")
        guard let client = Client(applicationID: applicationID, password: password) else {return}
        client.delegate = self
        client.processImage(image, with: ProcessingParams())
    }
    
}

extension ABBYHelper: ClientDelegate {
    func client(_ sender: Client!, didFinishDownloadData downloadedData: Data!) {
        guard let text = NSString.init(data: downloadedData, encoding: String.Encoding.utf8.rawValue) else {
            completion?(nil)
            return
        }
        completion?(String(text))
    }
    func clientDidFinishProcessing(_ sender: Client!) {
        print("finished processing ")
    }
    func clientDidFinishUpload(_ sender: Client!) {
        print("finished upload")
    }
    func client(_ sender: Client!, didFailedWithError error: Error!) {
        completion?(nil)
    }
}
