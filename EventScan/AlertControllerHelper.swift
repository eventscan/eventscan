//
//  AlertControllerHelper.swift
//  EventScan
//
//  Created by Abid Amirali on 4/7/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

struct AlertControllerHelper {
    
    static func presentAlert(for viewController: UIViewController, withTitle title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
