//
//  ContactsCell.swift
//  Contacts
//
//  Created by Johnny Perdomo on 12/18/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var isFavoriteImage: UIImageView!   // 1 =false
    //0 = true
    
    override func awakeFromNib() {
        contactImage.layer.cornerRadius = contactName.frame.height/2
    }
    
    func populateData(contactDetails : ContactModel) {
        contactName.text = contactDetails.firstName! + "" + contactDetails.lastName!
        
        if contactDetails.favourite == 0 {
            isFavoriteImage.isHidden = false
        }else{
            isFavoriteImage.isHidden = true
        }
        
        contactImage.image = UIImage(named: "placeholder_photo")
        
        if contactDetails.profilePic != "" && contactDetails.profilePic !=  "/images/missing.png"{
            contactImage.downloadImageFrom(link: contactDetails.profilePic ?? "", contentMode: .scaleAspectFit)
        }
        
        
    }
    
}
