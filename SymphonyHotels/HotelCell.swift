//
//  HotelCell.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class HotelCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var ratingStars: RatingControl!
    
    var hotel: Hotel? {
        didSet {
            if let hotel = hotel {
                nameLabel.text = hotel.name
                priceLabel.text = hotel.formattedPrice()
                ratingStars.rating = hotel.stars
                hotelImageView.loadImage(from: hotel.imageURL, withPlaceholder: nil)
            }
        }
    }
    
    // MARK: Cell lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hotelImageView.image = nil
    }
    
}
