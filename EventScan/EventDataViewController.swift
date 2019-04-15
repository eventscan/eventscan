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
    var inputText: String!
    var textData = [EventData]()
    var parsePosition = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDataTableView.allowsMultipleSelection = true
        
        //        textData = [EventData]()
        
        for line in inputText.split(separator: "\n") {
            for word in String(line).split(separator: " ") {
                let data = EventData(text: String(word))
                textData.append(data)
            }
        }
        
        self.eventDataTableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventDataCell", for: indexPath) as? EventDataCell else {return UITableViewCell()}
        
        let eventData = textData[indexPath.row]
        cell.eventDataLabel.text = eventData.text
        cell.accessoryType = eventData.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) else {return indexPath}
        let color = cell.backgroundView?.backgroundColor
        let isSelected = cell.accessoryType == .checkmark ? true : false
        textData[indexPath.row].isSelected = !isSelected
        cell.accessoryType = !isSelected ? .checkmark : .none
        return indexPath
    }
    

}

extension EventDataViewController: UITableViewDelegate {
    
}
