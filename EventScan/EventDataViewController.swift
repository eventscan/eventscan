//
//  EventDataViewController.swift
//  EventScan
//
//  Created by Abid Amirali on 4/8/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class EventDataViewController: UIViewController {

    @IBOutlet weak var eventDataTableView: UITableView!
    @IBOutlet weak var promptLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

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


extension EventDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    
}

extension EventDataViewController: UITableViewDelegate {}
