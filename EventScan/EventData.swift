//
//  EventData.swift
//  EventScan
//
//  Created by Abid Amirali on 4/10/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import Foundation

struct EventData {
    let text: String
    var isSelected: Bool
    
    init(text: String, isSelected: Bool = false) {
        self.text = text
        self.isSelected = isSelected
    }
    
}
