//
//  ViewController.swift
//  Contacts
//
//  Created by  Surbhi Natani On 5/9/2019
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet private weak var contactsTableView: UITableView!
    
    
    //MARK: Variables, Constants, Arrays
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let indexLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var indexLettersInContactsArray = ["A", "C", "J"]
    
    var namesArray = [String]()
    private var contactImagesArray = [UIImage]()
    
  //  var contactNamesDictionary = [String: [String]]() //i.e. ["A" : ["Anakin Skywalker" , "Astro Boy"], "C" : ["Charlie Brown"], "J" : ["Johnny Perdomo", "Jason Vorhees", "Julia Child"]
    
    
    var contactNamesDictionary = ["A" : ["Anakin Skywalker" , "Astro Boy"], "C" : ["Charlie Brown"], "J" : ["Johnny Perdomo", "Jason Vorhees", "Julia Child"]]
    private var contactImagesDictionary = ["Johnny Perdomo" : UIImage(named: "")] //i.e. "Johnny Perdomo" : <<Picture 27, User Picture >>
    private var contactFavoritesDictionary = [String: Bool]() //i.e "Ross Geller" : True, "Joey Tribiani" : False
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //MARK: VC Functions -----------------------------------------------------------------------------
    
   
    
    func createNameDictionary() {
        
        contactNamesDictionary.removeAll()
        for name in namesArray {
            
            let firstLetter = "\(name[name.startIndex])"
            let uppercasedLetter = firstLetter.uppercased()
            
            if var separateNamesArray = contactNamesDictionary[uppercasedLetter] { //check if key already exists
                separateNamesArray.append(name)
                contactNamesDictionary[uppercasedLetter] = separateNamesArray
            } else {
                contactNamesDictionary[uppercasedLetter] = [name]
            }
        }
        
        indexLettersInContactsArray = [String](contactNamesDictionary.keys)
        indexLettersInContactsArray = indexLettersInContactsArray.sorted()
    }
    
    @objc func showFavoriteContacts(){
        
    }
    
    @objc func sortContactsByType(){
        
    }
    
}

//MARK: TableView ------------------------------------------------------------------------------

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return contactNamesDictionary.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            var count = Int()
        
            let letter = indexLettersInContactsArray[section]
            
            if let names = contactNamesDictionary[letter] {
                count = names.count
            }
       
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactsCell else { return UITableViewCell() }
        
        var attributedText = NSAttributedString()
        var contactImage = UIImage()
        var isFavoriteBool = Bool()
            
            let letter = indexLettersInContactsArray[indexPath.section]
            
            if var names = contactNamesDictionary[letter.uppercased()] {
                names = names.sorted()
                
                let text = names[indexPath.row]
                let attributedString = NSMutableAttributedString(string: text)
                attributedText = attributedString
                
                let image = contactImagesDictionary[text]
                let favoriteBool = contactFavoritesDictionary[text]
                
                contactImage =  image 
                isFavoriteBool = favoriteBool!
            }
       
        
        cell.contactImage.image = contactImage
        cell.isFavoriteImage.isHidden = !(isFavoriteBool)
        cell.contactName.attributedText = attributedText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        var rowNumber = indexPath!.row
        for i in 0..<indexPath!.section {
            rowNumber += self.contactsTableView.numberOfRows(inSection: i)
        }
        
//        var fullName = String()
//
//        var firstName = String()
//        var lastName = String()
//        var dateOfBirth = String()
//        var phoneNumbers = NSObject()
//        var emails = NSObject()
//        var addresses = NSObject()
//        var contactImage = UIImage()
//        var favorite = Bool()
     
//            firstName = personArray[rowNumber].firstName!
//            lastName = personArray[rowNumber].lastName!
//            dateOfBirth = personArray[rowNumber].dateOfBirth!
//            phoneNumbers = personArray[rowNumber].phoneNumbers!
//            emails = personArray[rowNumber].emails!
//            addresses = personArray[rowNumber].addresses!
        //contactImagesArray = contactImagesDictionary[fullName]!
           // favorite = contactFavoritesDictionary[fullName]!
       
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionTitle = String()
        
            //         indexLettersInContactsArray = indexLettersInContactsArray.sorted(by: {$0 > $1})
            sectionTitle = indexLettersInContactsArray[section]
       
        
        return sectionTitle
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexLetters
    }
}



