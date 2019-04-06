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
        
        let abbyHelper = ABBYHelper()
        let image = UIImage(named: "testImage2.jpg")!
        
        
        abbyHelper.completion = { (text) in
            guard let text = text else {return}
            let parser = Parser()
            parser.parse(text: text)
        }
        
        
        abbyHelper.parse(image: image)
        
    }


}

