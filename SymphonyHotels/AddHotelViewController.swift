//
//  AddHotelViewController.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class AddHotelViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var starsTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    // MARK: Actions
    
    @IBAction func addHotel(_ sender: UIButton) {
                guard let stars = starsTextField.text,
                    let country = countryTextField.text,
                    let city = cityTextField.text,
                    let location = locationTextField.text,
                    let name = nameTextField.text,
                    let desc = descriptionTextField.text,
                    let price = priceTextField.text else {
                        return
                }
        
        let parameters: [String: Any] = [
            "stars": stars,
            "country": country,
            "city": city,
            "location": location,
            "name": name,
            "description" : desc,
            "price": price,
            "user": [2] // user is hardcoded.
        ]
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/hotel_api/", method: .post, parameters: parameters, completion: {
            [weak self] (status, response) in
            if status == .created {
                self?.presentAlert("Success", message: "Hotel created.")
            }else {
                
                self?.presentAlert("RESPONSE: ", message: "\(String(describing: response))")
            }
        })
    }
    

}
