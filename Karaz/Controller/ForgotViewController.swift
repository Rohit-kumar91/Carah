//
//  ForgotViewController.swift
//  Karaz
//
//  Created by Rohit Kumar on 28/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit

class ForgotViewController: UITableViewController {

    @IBOutlet var forgotPasswordTableview: UITableView!
    @IBOutlet weak var emailTextfield: UITextFieldX!
    var userObj = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordTableview.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
        forgotPasswordTableview.backgroundView?.contentMode = .bottom
    }
    
    @IBAction func submitButtonAction(_ sender: UIButtonX) {
        //FORGOT_PASSWORD
        userObj.email = emailTextfield.text!
        
        if userObj.isAllForgotFieldVerified(){
            forgotPassword()
        } else {
            AlertController.alert(title: APP_NAME, message: userObj.errorString, buttons: ["OK"]) { (UIAlertAction, index) in
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func forgotPassword() {
        
        self.view.endEditing(true)
        
        let param = [
            "email" : userObj.email
            ]
        
        ServiceHelper.sharedInstance.createPostRequest(isShowHud: true, params: param as [String : AnyObject], apiName: FORGOT_PASSWORD) { (response, error) in
            
            if error != nil {
                AlertController.alert(title: API_FAIL, message: (error?.description)!)
                return
            }
            
            if (response != nil) {
                let jsonResponse = JSON(response as Any)
                if jsonResponse["success"].boolValue {
                    //Success
                    AlertController.alert(title: API_SUCCESS, message: jsonResponse["message"].stringValue, buttons: ["Ok"], tapBlock: { (action, index) in
                        if index == 0 {
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                } else {
                    AlertController.alert(title: API_FAIL, message: jsonResponse["error"].stringValue)
                }
            }
        }
    }
    
}


extension ForgotViewController {
    
    //MARK: TableView Controller Delegate Method.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return tableView.bounds.height * 0.50
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
