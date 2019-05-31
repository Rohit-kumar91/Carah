//
//  RegisterationViewController.swift
//  Karaz
//
//  Created by Rohit Kumar on 28/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit

class RegisterationViewController: UITableViewController {

    @IBOutlet var registerationTableview: UITableView!
    @IBOutlet weak var fullNameTextfield: UITextFieldX!
    @IBOutlet weak var emailTextfield: UITextFieldX!
    @IBOutlet weak var phoneTextfield: UITextFieldX!
    @IBOutlet weak var passwordTextField: UITextFieldX!
    @IBOutlet weak var confirmPasswordTextField: UITextFieldX!
    
    var userObj = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerationTableview.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
        registerationTableview.backgroundView?.contentMode = .bottom
        
    }
    
    @IBAction func commonButtonAction(_ sender: UIButton) {
        
        if sender.tag == 100 {
            //For SignUp
            
            userObj.fullName = fullNameTextfield.text!
            userObj.email = emailTextfield.text!
            userObj.phoneNumebr = phoneTextfield.text!
            userObj.password = passwordTextField.text!
            userObj.confirmPassword = confirmPasswordTextField.text!
            
            if userObj.isAllFieldVerified(){
                signUpUser()
            } else {
                AlertController.alert(title: APP_NAME, message: userObj.errorString, buttons: ["OK"]) { (UIAlertAction, index) in
                }
            }
            
        } else {
            //For SignIn
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func signUpUser() {
        
        self.view.endEditing(true)
        
        let param = [
            "email" : userObj.email,
            "name" : userObj.fullName,
            "password" : userObj.confirmPassword,
            "phone" : userObj.phoneNumebr
        ]
        
        ServiceHelper.sharedInstance.createPostRequest(isShowHud: true, params: param as [String : AnyObject], apiName: SIGN_UP) { (response, error) in
            
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

extension RegisterationViewController {
    //MARK: TableView Controller Delegate Method.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
