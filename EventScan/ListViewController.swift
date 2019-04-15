//
//  ListViewController.swift
//  EventScan
//
//  Created by 이승헌 on 07/04/2019.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var events: [NSManagedObject] = []
    
    static var didSelect = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        CameraViewController.should_appear = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "EventInfo", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventInfo")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            print("loading data")
            
            //read data by each object
            events = result as! [NSManagedObject]

            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "event_name") as! String)
                print(data.value(forKey: "location") as! String)
                print(data.value(forKey: "date") as! Date)
                print(data.value(forKey: "time") as! Date)
                print(data.value(forKey: "alert") as! String)
                print(data.value(forKey: "details") as! String)
                print("----------------\n")
            }
            
        } catch {
            print("Failed")
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell") as! ListViewCell
        
        let event = events[indexPath.row];
        
        cell.eventName.text = event.value(forKey: "event_name") as? String
        let date = event.value(forKey: "date") as! Date
        let time = event.value(forKey: "time") as! Date
        let date_string = date.description.split(separator: " ")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        let combined = "\(date_string[0]) \(dateFormatterPrint.string(from: time))"
        cell.eventDate.text = combined
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ListViewController.didSelect = indexPath.row
        DetailViewController.fromList = true
        DetailViewController.fromParser = false
        DetailViewController.shouldSet = true
        tabBarController?.selectedIndex = 2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "EventInfo", in: context)
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventInfo")
            request.returnsObjectsAsFaults = false
            
            do {
                let result = try context.fetch(request)
                print("loading data")
                //read data by each object
                events = result as! [NSManagedObject]
                context.delete(events[indexPath.row])
            } catch {
                print("Failed")
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            do {
                let result = try context.fetch(request)
                print("loading data")
                //read data by each object
                events = result as! [NSManagedObject]
            } catch {
                print("Failed")
            }
            tableView.reloadData()
            
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
