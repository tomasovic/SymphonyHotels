//
//  FavoritesViewController.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class FavoritesViewController: HomeTableViewController {
    
    // MARK: Public Methods
    
    /// Get favorite hotels
    override func loadHotels() {
        hotels.removeAll()
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/favorites/", method: .get, parameters: nil) { [weak self] (status, response) in
            if status == .success {
                if let data = response as? JSONArray {
                    for json in data {
                        self?.hotels.append(Hotel(json: json))
                    }
                    
                    self?.tableView.reloadData()
                    print("Favorites: \(String(describing: self?.hotels.count))")
                }
            }
        }
    }
    
    
    /// Remove hotels from the favorites
    ///
    /// - Parameter hotelId: This is the id of the hotel
    override func remove(hotelId: Int) {
        let parameters = [
            "hotel_id": hotelId,
            "is_favorite": 0
        ]
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/favorites/add_remove", method: .post, parameters: parameters) { [weak self] (status, response) in
            self?.loadHotels()
        }
    }
    
}
