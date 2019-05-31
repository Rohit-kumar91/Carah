//
//  UserModel.swift
//  Karaz
//
//  Created by Rohit Kumar on 28/05/19.
//  Copyright © 2019 Rohit Kumar. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    var fullName = ""
    var email = ""
    var phoneNumebr = ""
    var password = ""
    var confirmPassword = ""
    var errorString = ""
    
    
    //MARK: Registeration Page Validation
    func isAllFieldVerified() -> Bool {
        
        if fullName.trimWhiteSpace.count == 0 {
            errorString = blankFullName
        } else if !fullName.isValidUserName() {
            errorString = validUserName
        } else if email.trimWhiteSpace.count == 0 {
            errorString = blankEmailAddress
        } else if !email.isEmail  {
            errorString = inValidEmailAddress
        } else if phoneNumebr.trimWhiteSpace.count == 0 {
            errorString = blankMobileNumber
        } else if (phoneNumebr.length < phoneMinLength || !phoneNumebr.containsNumberOnly() || phoneNumebr.isContainsAllZeros()) {
            errorString = inValidMobileNumber
        } else if password.trimWhiteSpace.count == 0 {
            errorString = blankPassword
        } else if password.trimWhiteSpace.length < 8 {
            errorString = inValidPassword
        } else if confirmPassword != password {
            errorString = passwordNotMatch
        } else {
            return true
        }
        return false
    }
    
    
    //MARK: Login Page Validation
    func isAllLoginFieldVerified() -> Bool {
        if email.trimWhiteSpace.count == 0 {
            errorString = blankEmailAddress
        } else if !email.isEmail  {
            errorString = inValidEmailAddress
        } else if password.trimWhiteSpace.count == 0 {
            errorString = blankPassword
        } else if password.trimWhiteSpace.length < 8 {
            errorString = inValidPassword
        } else {
            return true
        }
        return false
    }
    
     //MARK: ForgotPassword Page Validation
    func isAllForgotFieldVerified() -> Bool {
        if email.trimWhiteSpace.count == 0 {
            errorString = blankEmailAddress
        } else if !email.isEmail  {
            errorString = inValidEmailAddress
        }  else {
            return true
        }
        return false
    }
    
}
