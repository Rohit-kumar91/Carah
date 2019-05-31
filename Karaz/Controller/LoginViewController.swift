//
//  LoginViewController.swift
//  Karaz
//
//  Created by Rohit Kumar on 27/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {

    
    @IBOutlet var loginTableview: UITableView!
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    var userObj = UserModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    
    //MARk: Init Method
    func initialSetUp() {
        loginTableview.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
        loginTableview.backgroundView?.contentMode = .bottom
    }
    
    
    //MARK: Common Button Action
    @IBAction func commonButtonAction(_ sender: UIButton) {
        
        if sender.tag == 101 {
            //SignIn
            userObj.email = usernameTextfield.text!
            userObj.password = passwordTextfield.text!
            
            if userObj.isAllLoginFieldVerified(){
                signInUser()
            } else {
                AlertController.alert(title: APP_NAME, message: userObj.errorString, buttons: ["OK"]) { (UIAlertAction, index) in
                }
            }
        }
    }
    
    func signInUser() {
        
        self.view.endEditing(true)
        
        let param = [
            "username" : userObj.email,
            "password" : userObj.password,
        ]
        
        
        
        ServiceHelper.sharedInstance.createPostRequest(isShowHud: true, params: param as [String : AnyObject], apiName: SIGN_IN) { (response, error) in
            
            if error != nil {
                AlertController.alert(title: API_FAIL, message: (error?.description)!)
                return
            }
            
            if (response != nil) {
                let jsonResponse = JSON(response as Any)
                if jsonResponse["success"].boolValue {
                   //Success
                    
                    
                   UserDefaultValue.saveUserDefault(key: validUser, value: "xxxxx")
                } else {
                   AlertController.alert(title: API_FAIL, message: jsonResponse["error"].stringValue)
                }
            }
        }
    }
    
    
    
}

extension LoginViewController {
    
    //MARK: TableView Controller Delegate Method.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return tableView.bounds.height * 0.38
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
