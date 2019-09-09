//
//  AppConstants.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import Foundation

struct AppConstants {
    
   // App url
   static let BASE_URL = "https://gojek-contacts-app.herokuapp.com/"
    
   static let GET_CONTACTS = "contacts.json"
   static let EDIT_CONTACTS = "contacts"
    
    
    //Constants
    static let inValidFirstName = "Please enter a valid first name"
    static let inValidLastName = "Please enter a valid last name"
    static let inValidEmail = "Please enter a valid email"
    static let inValidMobileNumber = "Please enter a valid mobile number"
    static let successMessageProfileUpdate = "Profile updated successfully"
    static let successMessageAddProfile = "Profile added successfully"
    static let errorMessageProfileUpdate = "Failed to upload"
    static let errorMessageToGetContacts = "Failed to get contacts"
    static let errorTitle = "Error"
    static let successTitle = "Success"
}
