//
//  EditProfileVC.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var contactModel: ContactModel?
    lazy var viewModel: EditProfileViewModel = EditProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bindViewModelForRequestsCallBacks()
        initialSettings()
        
    }
    
    /// Initial settings to load view with some default settings
    func initialSettings(){
        let rightButtonItem = UIBarButtonItem.init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneBtnClicked(_:))
        )

        let leftButtonItem = UIBarButtonItem.init(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(cancelBtnClicked(_:))
        )


        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButtonItem
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        headerView.addGradient()
        profileImageView.layer.borderColor = UIColor.white.cgColor
        
        if let _ = contactModel {
            loadData()
        }
    }
    
    /// Load default data in controller
    func loadData(){
        emailTF.text = contactModel?.email
        firstNameTF.text = contactModel?.firstName
        lastNameTF.text = contactModel?.lastName
        mobileTF.text = contactModel?.phoneNumber
        
        profileImageView.image = UIImage(named: "placeholder_photo")
        
        if contactModel?.profilePic != "" && contactModel?.profilePic !=  "/images/missing.png"{
            profileImageView.downloadImageFrom(link: contactModel?.profilePic ?? "", contentMode: .scaleAspectFit)
        }
    }
    
    
   
    /// Bind ViewModel with the controller class
    private func bindViewModelForRequestsCallBacks() {
        viewModel.SuccessHandler.bind { (success) in
            
            DispatchQueue.main.async {
                self.hideProgressView()
                
                if let _ = self.contactModel{
                     self.showErrorAlertWithTitle(AppConstants.successTitle, message: AppConstants.successMessageProfileUpdate)
                }else{
                    self.firstNameTF.text = ""
                    self.lastNameTF.text = ""
                    self.emailTF.text = ""
                    self.mobileTF.text = ""
                    self.showErrorAlertWithTitle(AppConstants.successTitle, message: AppConstants.successMessageAddProfile)
                }
               
            }
            
        }
        
        viewModel.requestFailureHandler.bind { (error) in
            DispatchQueue.main.async {
                self.hideProgressView()
                self.showErrorAlertWithTitle(AppConstants.errorTitle, message: AppConstants.errorMessageProfileUpdate)
            }
        }
    }
    

    /// Used to move view up and down on keyboard appearance and disappearance
    ///
    /// - Parameter up: If up is true then view will move upside
    func animateTxtFld(up: Bool){
        
        let movementDistance = -200
        let movementDuration  = 0.3
        let movement = (up ? movementDistance : -movementDistance)
        UIView.animate(withDuration: movementDuration)
        {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        }
    }
    
    
    /// Check Validation on all the textfields if validations are correct then it will return true else return false
    ///
    /// - Returns: bool is the return type
    func checkValidations() -> Bool{
        
        if firstNameTF.text?.count == 0 {
            
            self.showErrorAlertWithTitle(AppConstants.errorTitle, message: AppConstants.inValidFirstName)
            return false
            
        }else if lastNameTF.text?.count == 0 {
            
            self.showErrorAlertWithTitle(AppConstants.errorTitle, message: AppConstants.inValidLastName)
            return false
            
        }else if emailTF.text?.count == 0 || !(emailTF.text?.isValidEmail)!{
            
            self.showErrorAlertWithTitle(AppConstants.errorTitle, message: AppConstants.inValidEmail)
            return false
            
        }
        else if mobileTF.text?.count == 0 || !(mobileTF.text?.isValidPhone)!{
            
            self.showErrorAlertWithTitle(AppConstants.errorTitle, message: AppConstants.inValidMobileNumber)
            return false
            
        }
        
        return true
    }
    
    //MARK:- Button Action Methods
    @objc func doneBtnClicked(_ sender : UIButton){
        
        if checkValidations(){
            self.view.endEditing(true)
            self.showProgressView(onWindow: true)
            
            var dict = [String: Any]()
            
            dict["first_name"] = firstNameTF.text
            dict["last_name"] = lastNameTF.text
            dict["email"] = emailTF.text
            dict["phone_number"] = mobileTF.text
            dict["profile_pic"] = ""
            dict["favorite"] = "false"
            
            if let _ = contactModel {
                if let contactId = contactModel?.id{
                    viewModel.sendRequestToEditContact(params: dict, contactId: String(contactId))
                }
            }else{
                viewModel.sendRequestToAddContact(params: dict)
            }
        }
       
        
    }
    
    @objc func cancelBtnClicked(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
   
    
    @IBAction func uploadPhotoButtonClicked(_ sender : UIButton){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
   

}


 // MARK: TextField Delegate Methods
extension EditProfileVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTxtFld(up: true)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        animateTxtFld(up: false)
    }
    
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- Image Picker Controller Delegate Methods
extension EditProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
