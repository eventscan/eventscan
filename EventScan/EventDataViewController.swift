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
    var textData = [EventData]()
    var parsePosition = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDataTableView.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func previousButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        self.parsePosition += 1
        if parsePosition >= 3 {
            self.performSegue(withIdentifier: "toDetailView", sender: self)
        }
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
        return self.textData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventDataCell", for: indexPath)
        
        let eventData = textData[indexPath.row]
        cell.textLabel?.text = eventData.text
        cell.accessoryType = eventData.isSelected ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        
        textData[indexPath.row].isSelected = !textData[indexPath.row].isSelected
        cell.accessoryType = textData[indexPath.row].isSelected ? .checkmark : .none
        
    }
}

extension EventDataViewController: UITableViewDelegate {}
