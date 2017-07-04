//
//  ReviewCell.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var review: Review! {
        didSet {
            if let author = review.author {
                nameLabel.text = author.name
            }
            
            messageLabel.text = review.message
            likesLabel.text = "\(review.likes)"
            dislikesLabel.text = "\(review.dislikes)"
            dateLabel.text = review.date
        }
    }
    
}
