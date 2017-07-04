//
//  HotelDetailsViewController.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit
import MapKit

class HotelDetailsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var hotel: Hotel!
    
    
    /// Save hotel details
    @IBAction func saveAction() {
        // For testing purposes, we will update only name and stars!
        
        let parameters: JSON = [
            "stars": ratingControl.rating,
            "country": hotel.country,
            "city": hotel.city,
            "location": "\(hotel.coordinate.latitude),\(hotel.coordinate.longitude)",
            "name": nameTextField.text!,
            "description": hotel.desc,
            "price": hotel.price,
            "user": [1] // i dont have id's for users
        ]
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/hotel_api/\(hotel.id)/", method: .put, parameters: parameters) { [weak self] (status, response) in
            self?.presentAlert("Success", message: "Hotel is updated.")
            print("RESPONSE: \(response as Any)")
        }
    }
    
    
    /// Add hotel to favorites
    @IBAction func addToFavoritesAction() {
        let parameters = [
            "hotel_id": hotel.id,
            "is_favorite": 1
        ]
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/favorites/add_remove", method: .post, parameters: parameters) { [weak self] (status, response) in
            self?.presentAlert("Success", message: "Hotel added to favorites")
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = hotel.name
        nameTextField.text = hotel.name
        descriptionTextView.text = hotel.desc
        priceTextField.text = hotel.formattedPrice()
        ratingControl.rating = hotel.stars
        hotelImageView.loadImage(from: hotel.imageURL, withPlaceholder: nil)
        
        // Map.
        mapView.addAnnotation(hotel)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: hotel.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
