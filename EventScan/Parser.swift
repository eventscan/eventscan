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
        
        
        var addressFound = false
        var lastFoundAddress = ""
        
        
        for i in 0..<words.count {
            for j in (i + 1)..<words.count {
                var checkString = ""
                for n in i...j {
                    checkString += " " + words[n]
                }
                predictionSentiment(from: checkString)
            }
        }
        
        
    }
    
    func predictionSentiment(from sentence:String) -> Double {
        if let prediction = try? addressModel.prediction(text: sentence) {
            print(prediction.label)
        }
        
        return 0
    }
    
    
    
    
    
    
}
