//
//  HomeTableViewController.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: Properties
    var hotels = [Hotel]()
    
    // MARK: Public Methods
    
    
    /// Load all the hotels
    func loadHotels() {
        hotels.removeAll()
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/hotel_api/", method: .get, parameters: nil) { [weak self] (status, response) in
            if status == .success {
                if let data = response as? JSONArray {
                    for json in data {
                        self?.hotels.append(Hotel(json: json))
                    }
                    
                    self?.tableView.reloadData()
                    //                    print("Hotels: \(String(describing: self?.hotels.count))")
                }
            }
        }
    }
    
    
    /// Remove the hotel
    ///
    /// - Parameter hotelId: The id of the hotel
    func remove(hotelId: Int) {
        RESTManager.shared.loadData(from: "\(BASE_URL)/hotel_api/\(hotelId)/", method: .delete, parameters: nil) { [weak self] (status, response) in
            if status == .noContent {
                self?.loadHotels()
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadHotels()
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelCell") as! HotelCell
        
        cell.hotel = hotels[indexPath.row]
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let hotel = hotels[indexPath.row]
        
        // Show hotel details.
        let detailsAction = UITableViewRowAction(style: .normal, title: "Details") { [weak self] (action, indexPath) in
            self?.tableView.isEditing = false
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let hotelDetailsViewController = storyboard.instantiateViewController(withIdentifier: "HotelDetailsViewController") as! HotelDetailsViewController
            hotelDetailsViewController.hotel = hotel
            self?.navigationController?.pushViewController(hotelDetailsViewController, animated: true)
        }
        detailsAction.backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        // Show hotel reviews.
        let reviewsAction = UITableViewRowAction(style: .normal, title: "Reviews") { [weak self] (action, indexPath) in
            self?.tableView.isEditing = false
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let reviewsViewController = storyboard.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
            reviewsViewController.hotel = hotel
            self?.navigationController?.pushViewController(reviewsViewController, animated: true)
        }
        reviewsAction.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        // Share hotel.
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { [weak self] (action, indexPath) in
            self?.tableView.isEditing = false
            
            let activityController = UIActivityViewController(activityItems: [hotel.name, hotel.imageURL], applicationActivities: nil)
            activityController.excludedActivityTypes = [UIActivityType.postToWeibo]
            self?.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        
        // Delete hotel.
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { [weak self] (action, indexPath) in
            self?.tableView.isEditing = false
            
            self?.remove(hotelId: hotel.id)
            self?.tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        
        return [detailsAction, reviewsAction, shareAction, deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 2.0, animations: { cell.alpha = 1 })
    }
    
}



























