//
//  EditProfileViewModel.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit

class EditProfileViewModel: NSObject {
    
    var requestFailureHandler: Dynamic<ErrorType>
    var SuccessHandler: Dynamic<Bool>
    
    override init() {
        SuccessHandler = Dynamic<Bool>()
        
        requestFailureHandler = Dynamic<ErrorType>()
        super.init()
    }
    
    
    /// Api call to edit exist contact
    ///
    /// - Parameters:
    ///   - params: dictionary to pass as a parameter
    ///   - contactId: contactID to append it in url
    func sendRequestToEditContact(params: [String: Any], contactId: String) {
        
        ServerManager.postRequest(url: AppConstants.BASE_URL+AppConstants.EDIT_CONTACTS+"/\(contactId).json", requestMethod: HttpMethod.PUT.rawValue, params: params) { (error, response) in
            if error == nil {
                
                self.SuccessHandler.value = true
            }else{
                self.requestFailureHandler.value = .requestFailure(error: error?.localizedDescription ?? AppConstants.errorMessageProfileUpdate)
            }
        }
    
        
    }
    
    
    /// Api call to add new contact
    ///
    /// - Parameter params: dictioanry to pass as parameter
    func sendRequestToAddContact(params: [String: Any]) {
        
        ServerManager.postRequest(url: AppConstants.BASE_URL+AppConstants.GET_CONTACTS, requestMethod: HttpMethod.POST.rawValue, params: params) { (error, response) in
            if error == nil {
                
                self.SuccessHandler.value = true
            }else{
                self.requestFailureHandler.value = .requestFailure(error: error?.localizedDescription ?? AppConstants.errorMessageProfileUpdate)
            }
        }
    }

}
