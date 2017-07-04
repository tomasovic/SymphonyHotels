//
//  Extensions.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    
    /// Load image from the network
    ///
    /// - Parameters:
    ///   - urlString: image url
    ///   - placeholder: image
    func loadImage(from urlString: String, withPlaceholder placeholder: UIImage? = nil) {
        image = placeholder
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async { [unowned self] in
                            self.image = image
                        }
                    }
                }
            }
        }
    }
    
}

extension UIViewController {
    
    
    /// Share hotel
    ///
    /// - Parameters:
    ///   - items: Item to share
    ///   - viewController: viewController
    func shareItems(_ items: [String], onViewController viewController: UIViewController) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivityType.postToWeibo]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityController.modalPresentationStyle = .popover
            activityController.popoverPresentationController?.sourceView = self.view
        }
        
        viewController.present(activityController, animated: true, completion: nil)
    }
    
    
    /// Alert popup
    ///
    /// - Parameters:
    ///   - title: Title
    ///   - message: Message
    func presentAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
