//
//  Parser.swift
//  EventScan
//
//  Created by Abid Amirali on 4/1/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import Foundation

class Parser {
    
    var keywordMap: [String: String]
    
    init() {
        self.keywordMap = [String: String]()
    }
    
    
    func parse(text: String) {
        // checking if there is input to parse
        guard text.count > 0 else {return}
        
        let words = text.split(separator: " ")
        
    }
    
    
    
    
}
