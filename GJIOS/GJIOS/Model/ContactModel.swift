//
//  ContactModel.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit

class ContactModel {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var id: Int?
    var profilePic: String?
    var favourite: Int?
    
    
    init(dict : Dictionary<String,Any>) {
    
        firstName = dict["first_name"] as? String ?? ""
        lastName  = dict["last_name"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        phoneNumber  = dict["phone_number"] as? String ?? ""
        id = dict["id"] as? Int ?? 0
        profilePic  = dict["profile_pic"] as? String ?? ""
        favourite  = dict["favorite"] as? Int ?? 0
    }

}
