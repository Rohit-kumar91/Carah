//
//  MenuViewController.swift
//  Karaz
//
//  Created by Rohit Kumar on 29/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menutableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menutableView.reloadData()
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButtonX) {
        
        sideMenuController?.hideMenu()
        logout()
        
    }
    
    func logout() {
        ServiceHelper.sharedInstance.createGetRequest(isShowHud: true, apiName: LOGOUT) { (response, error) in
            if error != nil {
                AlertController.alert(title: API_FAIL, message: (error?.description)!)
                return
            }
            
            if (response != nil) {
                let jsonResponse = JSON(response as Any)
                print(jsonResponse)
                
                if jsonResponse["success"].boolValue {
                    //Success
                    UserDefaultValue.removeUserDefault(key: validUser)
                    
                } else {
                    AlertController.alert(title: API_FAIL, message: jsonResponse["error"].stringValue)
                }
            }
        }
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.instance.categoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryTableViewCell
        cell.categoryLabel.text = Singleton.instance.categoryData[indexPath.row]["name"]["en"].stringValue
        return cell
    }
    
}
