//
//  MenuItemDetailViewController.swift
//  BookRestaurant
//
//  Created by Gabriel Blaine Palmer on 1/3/19.
//  Copyright © 2019 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var menuItem: MenuItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 5.0
        updateUI()
    }
    
    func updateUI() {
        nameLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = "- " + menuItem.detailText
        
        MenuController.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
        MenuController.sharedOrder.menuItems.append(menuItem)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.addButton.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.addButton.transform = .identity
            })
        }
        
    }
    
}

