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
    var eventName: String?
    var eventDate: String?
    var eventLocation: String?
    var eventDetail: String?
    var name_segment = [EventData]()
    var date_segment = [EventData]()
    var location_segment = [EventData]()
    var myTabBarController: UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDataTableView.allowsMultipleSelection = true
        print(inputText)
        if (inputText == nil || inputText.isEmpty) {
            print("inside")
            
            let alertController = UIAlertController(title: "Error", message:
                "No word detected", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
                    print("test")
                   self.dismiss(animated: true, completion: nil)
            })
            
          
            self.present(alertController, animated: true, completion: nil)
        } else {
            for line in inputText.split(separator: "\n") {
                let data = EventData(text: String(line))
                textData.append(data)
    //            for word in String(line).split(separator: " ") {
    //                let data = EventData(text: String(word))
    //                textData.append(data)
    //            }
            }
            
            self.eventDataTableView.reloadData()
        }
    }
  
    
    @IBAction func previousButtonPressed(_ sender: UIBarButtonItem) {
        self.parsePosition -= 1
        if (self.parsePosition < 0) {
            self.parsePosition = 0
            self.inputText = nil
            self.textData = [EventData]()
            print(self.inputText)
            self.dismiss(animated: true) {
                
            }
        }
        change_label(position: self.parsePosition)
        for data in textData {
            data.isSelected = false
        }
        switch (self.parsePosition) {
        case 0:
            for data in name_segment {
//                data.isSelected = false
                textData.append(data)
            }
            name_segment = [EventData]()
            break
        case 1:
            for data in date_segment{
//                data.isSelected = false
                textData.append(data)
            }
            date_segment = [EventData]()
            break
        case 2:
            for data in location_segment {
//                data.isSelected = false
                textData.append(data)
            }
            location_segment = [EventData]()
            break
        default:
            break
        }
        eventDataTableView.reloadData()
        
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        var combined_string = String()
        if (textData.count > 0){
        for i in 0...(textData.count - 1) {
            let data = textData[i]
            if(data.isSelected) {
                combined_string += " \(data.text)"
                switch (self.parsePosition) {
                case 0:
                    name_segment.append(data)
                    break
                case 1:
                    date_segment.append(data)
                    break
                case 2:
                    location_segment.append(data)
                default:
                    break
                }
            }
            
        }
        }
        textData = textData.filter({!$0.isSelected})
        save_data(position: self.parsePosition, combined_text: combined_string)
        self.parsePosition += 1
        change_label(position: self.parsePosition)
        if parsePosition >= 4 {
//            self.performSegue(withIdentifier: "toDetailView", sender: self)
            self.parsePosition = 0
            self.inputText = nil
            self.textData = [EventData]()
            self.dismiss(animated: true) {
                DetailViewController.event = Event(name: self.eventName ?? String(), location: self.eventLocation ?? String(), date: self.eventDate ?? String(), detail: self.eventDetail ?? String())
                self.myTabBarController?.selectedIndex = 2
                DetailViewController.fromParser = true
                DetailViewController.shouldSet = true
            }
            
        }
        eventDataTableView.reloadData()
    }
    
    func change_label(position:Int) {
        switch position {
        case 0:
            promptLabel.text = "Pick the event name"
            break
        case 1:
            promptLabel.text = "Pick the event date"
            break
        case 2:
            promptLabel.text = "Pick the event location"
            break
        case 3:
            promptLabel.text = "Pick the details"
            break
        default:
            break
        }
    }
    func save_data( position:Int, combined_text: String) {
        switch position {
        case 0:
            self.eventName = combined_text
            break
        case 1:
            self.eventDate = combined_text
            break
        case 2:
            self.eventLocation = combined_text
            break
        case 3:
            self.eventDetail = combined_text
            break
        default:
            break
        }
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//        guard let identifier = segue.identifier else {return}
//        if identifier == "toDetailView" {
//            guard let vc = segue.destination as? DetailViewController, let name = self.eventName, let location = self.eventLocation, let date = self.eventDate else {return}
////            vc.event = Event(name: name, location: location, date: date)
//        }
//        
//     }
    
    
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
        let data = textData[indexPath.row]
        data.isSelected = true
        cell.accessoryType = .checkmark
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) else {return indexPath}
        let data = textData[indexPath.row]
        data.isSelected = false
        cell.accessoryType = .none
        return indexPath
    }
    

}

extension EventDataViewController: UITableViewDelegate {
    
}
