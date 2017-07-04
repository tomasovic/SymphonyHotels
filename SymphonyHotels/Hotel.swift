//
//  Hotel.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Hotel: NSObject {
    
    // MARK: Properties
    var id:         Int = 0
    var name:       String = ""
    var city:       String = ""
    var country:    String = ""
    var imageURL:   String = ""
    var stars:      Int = 0
    var desc:       String = ""
    var price:      Double = 0.0
    var likes:      Int = 0
    var dislikes:   Int = 0
    var latitude:   Double = 0.0
    var longitude:  Double = 0.0
    var reviews =   [Review]()
    
    // MARK: Initializers
    init(json: JSON) {
        if let id = json["id"] as? Int {
            self.id = id
        }
        
        if let name = json["name"] as? String {
            self.name = name
        }
        
        if let city = json["city"] as? String {
            self.city = city
        }
        
        if let country = json["country"] as? String {
            self.country = country
        }
        
        if let image = json["image"] as? String {
            self.imageURL = image
        }
        
        if let stars = json["stars"] as? Int {
            self.stars = stars
        }
        
        if let description = json["description"] as? String {
            self.desc = description
        }
        
        if let price = json["price"] as? Double {
            self.price = price
        }
        
        if let likes = json["likes"] as? Int {
            self.likes = likes
        }
        
        if let dislikes = json["dislikes"] as? Int {
            self.dislikes = dislikes
        }
        
        if let location = json["location"] as? String {
            let array = location.components(separatedBy: ",")
            if array.count == 2 {
                if let latitude = Double(array[0].trimmingCharacters(in: .whitespaces)) {
                    self.latitude = latitude
                }
                
                if let longitude = Double(array[1].trimmingCharacters(in: .whitespaces)) {
                    self.longitude = longitude
                }
            }
        }
    }
    
    // MARK: - Public API
    func formattedPrice() -> String {
        return "$\(price)"
    }
    
    func getReviews(completion: @escaping () -> ()) {
        reviews.removeAll()
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/hotel_api/get_hotel_reviews/\(id)/", method: .get, parameters: nil) { [weak self] (status, response) in
            
            if status == .success {
                if let data = response as? JSONArray {
                    for json in data {
                        self?.reviews.append(Review(json: json))
                    }
                    
                    completion()
                    print("Reviews: \(String(describing: self?.name)): \(String(describing: self?.reviews.count))")
                }
            } else {
                completion()
            }
        }
    }
    
}

extension Hotel: MKAnnotation {
    
    // MARK: - MKAnnotation
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return description
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
