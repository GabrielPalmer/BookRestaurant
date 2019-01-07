//
//  ConfirmationViewController.swift
//  BookRestaurant
//
//  Created by Gabriel Blaine Palmer on 1/4/19.
//  Copyright © 2019 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let menuIDs = MenuController.sharedOrder.menuItems.map { $0.id }
        
        MenuController.submitOrder(forMenuIDs: menuIDs) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.timeLabel.text = "\(minutes) minutes"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dissmissSegue" {
            MenuController.sharedOrder.menuItems.removeAll()
        }
    }

}
