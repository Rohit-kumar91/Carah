//
//  MyAccountViewController.swift
//  Karaz
//
//  Created by Rohit Kumar on 30/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    let myAccountArray = ["My Account", "My Orders", "Saved Cards", "About Us", "FAQs", "Privacy Policy", "Terms and Conditions", "Logout"]
    
    
    @IBOutlet weak var myAccountTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
   
}

extension MyAccountViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAccountArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyAccountTableViewCell
        cell.accountLabel.text = myAccountArray[indexPath.row]
        return cell
    }
    
    
}
