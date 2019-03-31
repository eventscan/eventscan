//
//  DetailViewController.swift
//  EventScan
//
//  Created by 이승헌 on 31/03/2019.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker_display_data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker_display_data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_index = row
    }
   
    @IBOutlet weak var alert_picker: UIPickerView!
    var picker_display_data: [String] = [String]()
    var selected_index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert_picker.delegate = self
        self.alert_picker.dataSource = self
        picker_display_data = ["10 minute","5 minute","15 minute","Never"]
        alert_picker.selectRow(1, inComponent: 0, animated: true)
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
