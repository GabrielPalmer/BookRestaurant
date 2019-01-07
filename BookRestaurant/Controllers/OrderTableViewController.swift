//
//  OrderTableViewController.swift
//  BookRestaurant
//
//  Created by Gabriel Blaine Palmer on 1/3/19.
//  Copyright © 2019 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView, selector:
            #selector(UITableView.reloadData), name:
            MenuController.orderUpdatedNotification, object: nil)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        let orderTotal =
            MenuController.sharedOrder.menuItems.reduce(0.0)
            { (result, menuItem) -> Double in
                return result + menuItem.price
        }
        
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
                self.performSegue(withIdentifier: "submitSegue", sender: nil)
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuController.sharedOrder.menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderItemCell", for: indexPath)
        let menuItem = MenuController.sharedOrder.menuItems[indexPath.row]
        
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)

        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.sharedOrder.menuItems.remove(at: indexPath.row)
            
            if MenuController.sharedOrder.menuItems.count > 0 {
                submitButton.isEnabled = true
            } else {
                submitButton.isEnabled = false
            }
        }
    }

}
