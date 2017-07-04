//
//  RatingControl.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet
        {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 80.0, height: 15.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    func ratingButtonPress(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            return
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        }else {
            rating = selectedRating
        }
    }
    
    // MARK: Private methods
    
    
    /// Adding buttons to collection, setup buttons
    /// Remove buttons if placed from storyboard - Inspectable
    /// Adding constraints
    private func setupButtons() {
        // Storyboard
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Image Setting
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "star_full", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "star_empty", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.heightAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.tag = index
            
            // Placing action for button
            button.addTarget(self, action: #selector(RatingControl.ratingButtonPress(button:)), for: .touchUpInside)
            
            // Arrange buttons on the view
            addArrangedSubview(button)
            
            // Add button to collection
            ratingButtons.append(button)
            
            // Update selected button
            updateButtonSelectionStates()
        }
    }
    
    /// Looking at rating and position than place selected state
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
