//
//  DetailViewController.swift
//  EventScan
//
//  Created by 이승헌 on 31/03/2019.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var event_name: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var date_picker: UIDatePicker!
    @IBOutlet weak var time_picker: UIDatePicker!
    @IBOutlet weak var alert_picker: UIPickerView!
    @IBOutlet weak var event_details: UITextView!
    var alert_picker_display_data: [String] = [String]()
    var selected_index = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert_picker.delegate = self
        self.alert_picker.dataSource = self
        alert_picker_display_data = ["10 minute","5 minute","15 minute","Never"]
        alert_picker.selectRow(selected_index, inComponent: 0, animated: true)
    }
    
    @IBAction func cancel_button(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    @IBAction func confirm_button(_ sender: Any) {
        // TO DO: Add the info to the lsit
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "EventInfo", in: context)
        //create new
        let newEventInfo = NSManagedObject(entity: entity!, insertInto: context)
        newEventInfo.setValue(event_name.text, forKey: "event_name")
        newEventInfo.setValue(location.text, forKey: "location")
        newEventInfo.setValue(date_picker.date, forKey: "date")
        newEventInfo.setValue(time_picker.date, forKey: "time")
        newEventInfo.setValue(alert_picker_display_data[alert_picker.selectedRow(inComponent: 0)], forKey: "alert")
        newEventInfo.setValue(event_details.text, forKey: "details")
        //saving
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        tabBarController?.selectedIndex = 1
        
        
        //reading
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventInfo")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print("loading data")
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "event_name") as! String)
            }
            
        } catch {
            print("Failed")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alert_picker_display_data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return alert_picker_display_data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_index = row
    }
    
    
}
