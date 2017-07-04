//
//  Author.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import Foundation

class Author {
    
    // MARK: Properties
    var id:         Int = 0
    var firstName:  String = ""
    var lastName:   String = ""
    
    var name: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    // MARK: Initializers
    init(json: JSON) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        
        if let firstName = json["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = json["last_name"] as? String {
            self.lastName = lastName
        }
    }
    
}
