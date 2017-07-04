//
//  Review.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import Foundation

class Review {
    
    // MARK: Properties
    var id:             Int = 0
    var message:        String = ""
    var createdAt:      String = ""
    var createdDate =   Date()
    var likes:          Int = 0
    var dislikes:       Int = 0
    var positive:       Bool = false
    var author:         Author?
    
    var date: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            return dateFormatter.string(from: createdDate)
        }
    }
    
    // MARK: Initializers
    init(json: JSON) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        
        if let message = json["message"] as? String {
            self.message = message
        }
        
        if let createdAt = json["created_at"] as? String {
            self.createdAt = createdAt
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
            if let date = dateFormatter.date(from: createdAt) {
                createdDate = date
            }
        }
        
        if let likes = json["likes"] as? Int {
            self.likes = likes
        }
        
        if let dislikes = json["dislikes"] as? Int {
            self.dislikes = dislikes
        }
        
        if let positive = json["positive"] as? Bool {
            self.positive = positive
        }
        
        if let json = json["author"] as? JSON {
            self.author = Author(json: json)
        }
    }
    
}
