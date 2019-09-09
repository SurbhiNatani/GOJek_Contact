//
//  ProfileDetailVC.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit

class ProfileDetailVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var contactModel: ContactModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialSettings()
        loadData()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor  = UIColor.clear
        navigationController?.navigationBar.barTintColor  = UIColor.clear
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        if let layer = headerView.layer.sublayers?.first as? CAGradientLayer {
            layer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerView.frame.height)
        }
        
    }
    
    /// Initial settings to load view with some default settings
    func initialSettings(){
        let rightButtonItem = UIBarButtonItem.init(
            title: "Edit",
            style: .done,
            target: self,
            action: #selector(editButtonClicked(_:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        headerView.addGradient()
        
        favouriteBtn.setImage(UIImage(named: "favourite_button_selected"), for: .selected)
      
       
    }
    
     /// Load default data in controller
    func loadData(){
        
        if let firstName = contactModel?.firstName, let lastName = contactModel?.lastName{
             nameLbl.text = firstName + " " + lastName
        }
       
        mobileLbl.text = contactModel?.phoneNumber
        emailLbl.text = contactModel?.email
        
        if contactModel?.favourite == 0{
           favouriteBtn.isSelected = true
        }else{
           favouriteBtn.isSelected = false
        }
        
        profileImageView.image = UIImage(named: "placeholder_photo")
        
        if contactModel?.profilePic != "" && contactModel?.profilePic !=  "/images/missing.png"{
            profileImageView.downloadImageFrom(link: contactModel?.profilePic ?? "", contentMode: .scaleAspectFit)
        }
    }
    
    //MARK:- Button Action Methods
    @objc func editButtonClicked(_ sender : UIButton){
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        vc.contactModel = contactModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    
    @IBAction func callButtonAction(_ sender: UIButton){
        
        if let mobileNumber = contactModel?.phoneNumber{
            UIApplication.shared.open(URL(string: "tel://\(mobileNumber)")!, options:[:], completionHandler: nil)
        }
        
    }
    
    @IBAction func messageButtonAction(_ sender: UIButton){
        if let mobileNumber = contactModel?.phoneNumber{
            UIApplication.shared.open(URL(string: "sms:\(mobileNumber)")!, options:[:], completionHandler: nil)
        }
    }
    
    @IBAction func emailButtonAction(_ sender: UIButton){
        if let email = contactModel?.email{
            UIApplication.shared.open(URL(string: "mailto:/\(email)")!, options:[:], completionHandler: nil)
        }
    }

}
