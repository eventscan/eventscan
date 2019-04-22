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
    var currentText = ""
    var dataStateStack = [[EventData]]()
    var parsePosition = 0 {
        didSet {
            self.updateLabel(position: self.parsePosition)
        }
    }
    
    var eventDetailsMap = [String: String]()
    var myTabBarController: UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDataTableView.allowsMultipleSelection = true
        print(inputText)
        guard (inputText != nil && !inputText.isEmpty) else {
            print("inside")
            
            let alertController = UIAlertController(title: "Error", message:
                "No word detected", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
                CATransaction.setCompletionBlock({
                    print("test")
                    self.dismiss(animated: true, completion: nil)
                })
            })
            
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        for line in inputText.split(separator: "\n") {
            //            let data = EventData(text: String(line))
            for word in String(line).split(separator: " ") {
                let data = EventData(text: String(word))
                textData.append(data)
                
            }
        }
        
        self.eventDataTableView.reloadData()
        
    }
    
    
    @IBAction func previousButtonPressed(_ sender: UIBarButtonItem) {
        var key = getMapDetailItem()!
        self.eventDetailsMap[key] = nil
        self.parsePosition -= 1
        guard self.parsePosition >= 0 else {self.dismiss(animated: true); return}
        
        key = getMapDetailItem()!
        self.currentText = self.eventDetailsMap[key] ?? ""
        self.textData = self.dataStateStack.removeLast()
        eventDataTableView.reloadData()
        
    }
    
    func getMapDetailItem() -> String? {
        switch (self.parsePosition) {
        case 0:
            return  "name"
        case 1:
            return  "day"
        case 2:
            return  "month"
        case 3:
            return  "year"
        case 4:
            return  "time"
        case 5:
            return "location"
        case 6:
            return "other"
        default:
            return nil
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        guard let key = getMapDetailItem() else {return}
        self.dataStateStack.append(self.textData)
        self.textData = textData.filter {!$0.isSelected}
        self.parsePosition += 1
        self.eventDetailsMap[key] = self.currentText
        self.currentText = ""
        
        guard parsePosition > 6 else {
            self.eventDataTableView.reloadData()
            return
        }
        
        
        //            self.performSegue(withIdentifier: "toDetailView", sender: self)
        self.parsePosition = 0
        self.inputText = nil
        self.textData = []
        self.dismiss(animated: true) {
            let name = self.eventDetailsMap["name"] ?? ""
            let day = self.eventDetailsMap["day"] ?? ""
            let month = self.eventDetailsMap["month"]  ?? ""
            let year = self.eventDetailsMap["year"] ?? ""
            let time = self.eventDetailsMap["time"] ?? ""
            let location = self.eventDetailsMap["location"] ?? ""
            let otherDetails = self.eventDetailsMap["other"] ?? ""
            DetailViewController.event = Event(name: name, location: location, day: day, time: time, year: year, month: month, detail: otherDetails)
            self.myTabBarController?.selectedIndex = 2
            DetailViewController.fromParser = true
            DetailViewController.shouldSet = true
        }
        
        
        //        eventDataTableView.reloadData()
    }
    
    func updateLabel(position:Int) {
        switch position {
        case 0:
            promptLabel.text = "Pick the event name"
            break
        case 1:
            promptLabel.text = "Pick the event day"
            break
        case 2:
            promptLabel.text = "Pick the event month"
            break
        case 3:
            promptLabel.text = "Pick the event year"
            break
        case 4:
            promptLabel.text = "Pick the event time"
            break
        case 5:
            promptLabel.text = "Pick the event location"
            break
        case 6:
            promptLabel.text = "Pick other details"
            break
        default:
            break
        }
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
        self.currentText += " " + data.text
        self.currentText = self.currentText.trimmingCharacters(in: CharacterSet.whitespaces)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) else {return indexPath}
        let data = textData[indexPath.row]
        data.isSelected = false
        cell.accessoryType = .none
        guard let endIndex = self.currentText.lastIndex(of: " ") else {return indexPath}
        self.currentText = String(self.currentText[self.currentText.startIndex..<endIndex])
        return indexPath
    }
    
    
}

extension EventDataViewController: UITableViewDelegate {
    
}
