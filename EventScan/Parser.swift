//
//  Parser.swift
//  EventScan
//
//  Created by Abid Amirali on 4/1/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import Foundation
import CoreML

class Parser {
    let addressModel = AddressModel()

    var keywordMap: [String: String]
    
    init() {
        self.keywordMap = [String: String]()
    }
    
    
    func parse(text: String) {
        // checking if there is input to parse
        guard text.count > 0 else {return}
        
        let words = text.split(separator: " ")
        
        
        var i = 0
        
        var addressFound = false
        var lastFoundAddress = ""
        
        
        while (!addressFound && i < words.count) {
            
            var check = words.first!
            if (words.count > 0) {
                
                check = ""
                for j in 0...i {
                    check += " " + words[j]
                }
            }
            predictionSentiment(from: String(check))
            
            
           i += 1
            
            
        }
        
        
    }
    
    func predictionSentiment(from sentence:String) -> Double {
        if let prediction = try? addressModel.prediction(text: sentence) {
            print(prediction.label)
        }
        
        return 0
    }
    
    
    
    
    
    
}
