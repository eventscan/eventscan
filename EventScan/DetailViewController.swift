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
    static var fromParser: Bool = false
    static var fromList: Bool = false
    
    
    @IBOutlet weak var confirm_button: UIButton!
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
    
    override func viewDidAppear(_ animated: Bool) {
        CameraViewController.should_appear = true
        print("current from list: \(DetailViewController.fromList)")
        print("current from parser: \(DetailViewController.fromParser)")
        if (DetailViewController.fromParser) {
            
            
        }
        
        if (DetailViewController.fromList) {
            confirm_button.setTitle("Edit", for: .normal)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "EventInfo", in: context)
            
            //reading
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventInfo")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                print("loading data")
                
                //read data by each object
                let events = result as! [NSManagedObject]
                event_name.text = events[ListViewController.didSelect].value(forKey: "event_name") as! String
                location.text = events[ListViewController.didSelect].value(forKey: "location") as! String
                date_picker.date = events[ListViewController.didSelect].value(forKey: "date") as! Date
                time_picker.date = events[ListViewController.didSelect].value(forKey: "time") as! Date
                event_details.text = events[ListViewController.didSelect].value(forKey: "details") as! String
                
                let alert_string = events[ListViewController.didSelect].value(forKey: "alert") as! String
                for index in 0...(alert_picker_display_data.count - 1) {
                    if (alert_string == alert_picker_display_data[index]) {
                        alert_picker.selectRow(index, inComponent: 0, animated: true)
                        selected_index = index
                    }
                }
                
            } catch {
                print("Failed")
            }
            
           
        } else {
            confirm_button.setTitle("Confirm", for: .normal)
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancel_button(_ sender: Any) {
        event_name.text = ""
        location.text = ""
        date_picker.date = Date()
        time_picker.date = Date()
        alert_picker.selectRow(1, inComponent: 0, animated: true)
        selected_index = 1
        event_details.text = ""
        if (DetailViewController.fromParser) {
            tabBarController?.selectedIndex = 0
        }
        if (DetailViewController.fromList) {
            tabBarController?.selectedIndex = 1
        }
        DetailViewController.fromList = false
        DetailViewController.fromParser = false
        print("successful")
    }
    
    @IBAction func confirm_button(_ sender: Any) {
        print("is empty \(event_name.text?.isEmpty),\(location.text?.isEmpty)")
        if (event_name.text?.isEmpty == false && location.text?.isEmpty == false) {
            if (!DetailViewController.fromList){
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "EventInfo", in: context)
                //create new
                let newEventInfo = NSManagedObject(entity: entity!, insertInto: context) //insert this object to the array
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
                event_name.text = ""
                location.text = ""
                date_picker.date = Date()
                time_picker.date = Date()
                alert_picker.selectRow(1, inComponent: 0, animated: true)
                selected_index = 1
                event_details.text = ""
                DetailViewController.fromParser = false
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "EventInfo", in: context)

                //editing
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventInfo")
                request.returnsObjectsAsFaults = false
                
                do {
                    let result = try context.fetch(request)
                    print("loading data")
                 
                    //update by index
                    var events = result as! [NSManagedObject]
                    events[ListViewController.didSelect].setValue(event_name.text, forKey: "event_name")
                    events[ListViewController.didSelect].setValue(location.text, forKey: "location")
                    events[ListViewController.didSelect].setValue(date_picker.date, forKey: "date")
                    events[ListViewController.didSelect].setValue(time_picker.date, forKey: "time")
                    events[ListViewController.didSelect].setValue(alert_picker_display_data[alert_picker.selectedRow(inComponent: 0)], forKey: "alert")
                    events[ListViewController.didSelect].setValue(event_details.text, forKey: "details")
                    
                    /*
                    //try remove the last element
                    context.delete(events[events.count - 1])
                     */
                    
                    //save
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                    }
                  
                } catch {
                    print("Failed")
                }
                event_name.text = ""
                location.text = ""
                date_picker.date = Date()
                time_picker.date = Date()
                alert_picker.selectRow(1, inComponent: 0, animated: true)
                selected_index = 1
                event_details.text = ""
                DetailViewController.fromList = false
            }
            tabBarController?.selectedIndex = 1
        } else {
            print("Event Name / Location is Empty")
            let alertController = UIAlertController(title: "Required", message:
                "Event Name / Location is Empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //below is for picker do not touch it
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
