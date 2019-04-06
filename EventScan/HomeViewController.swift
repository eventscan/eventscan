//
//  ViewController.swift
//  EventScan
//
//  Created by 이승헌 on 18/03/2019.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "testImage2.jpg")!
        
        VisionHelper.parseTextFrom(image: image) { (text) in
            guard let text = text else {
                //TODO: present error
                return}
            let parser = Parser()
            
            parser.parse(text: text)
        }
        
    }


}

