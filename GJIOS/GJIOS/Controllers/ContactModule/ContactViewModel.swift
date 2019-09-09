//
//  ContactViewModel.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit

class ContactViewModel: NSObject {
    
    var requestFailureHandler: Dynamic<ErrorType>
    var contactListSuccessHandler: Dynamic<Bool>
    var contactNamesDictionary = [String: [ContactModel]]()
    
    override init() {
        contactListSuccessHandler = Dynamic<Bool>()
        requestFailureHandler = Dynamic<ErrorType>()
        super.init()
    }
    
    //MARK: Get Contacts
    func sendRequestToGetContact() {
        
        ServerManager.getRequest(url: AppConstants.BASE_URL+AppConstants.GET_CONTACTS, requestMethod: HttpMethod.GET.rawValue) { (error, response) in 
            
            if error == nil {
                self.createNameDictionary(nameArray: response!)
                self.contactListSuccessHandler.value = true
            }else{
                self.requestFailureHandler.value = .requestFailure(error: error?.localizedDescription ?? "Something went wrong")
            }
        }
       
    }
    
    
    func createNameDictionary(nameArray : [[String: Any]]) {
     
        contactNamesDictionary.removeAll()
        
        for name in nameArray {
            
            let firstName = name["first_name"] as! String
            
            let firstLetter = "\(firstName[(firstName.startIndex)])"
            let uppercasedLetter = firstLetter.uppercased()
            
            if var separateNamesArray = contactNamesDictionary[uppercasedLetter] { //check if key already exists
                
                separateNamesArray.append(ContactModel(dict: name))
                contactNamesDictionary[uppercasedLetter] = separateNamesArray
            } else {
                contactNamesDictionary[uppercasedLetter] = [ContactModel(dict: name)]
            }
        }
        
    }
    

}
