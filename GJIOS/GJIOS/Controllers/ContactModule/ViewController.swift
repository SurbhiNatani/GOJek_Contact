//
//  ViewController.swift
//  GJIOS
//
//  Created by  Surbhi Natani On 5/9/2019
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet private weak var contactsTableView: UITableView!
    lazy var viewModel = {ContactViewModel()}()
    
    //MARK: Variables, Constants, Arrays
    private var indexLetters: [String] = {
        (65...90).map({String(Character(UnicodeScalar($0)))})
    }()
   
    private var indexLettersInContactsArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    /// Initial settings to load view with some default settings
    func initialSettings(){
        contactsTableView.tableFooterView = UIView()
        let rightButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(addButtonClicked(_:)))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        bindViewModelForRequestsCallBacks()
        showProgressView(onWindow: true)
        viewModel.sendRequestToGetContact()
    }
    
//    MARK:- Button Action Methods
    @objc func addButtonClicked(_ sender : UIButton){

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     /// Bind ViewModel with the controller class
    private func bindViewModelForRequestsCallBacks() {
        viewModel.contactListSuccessHandler.bind { (success) in
            DispatchQueue.main.async {
                self.indexLettersInContactsArray  = self.viewModel.contactNamesDictionary.keys.sorted()
                self.contactsTableView.reloadData()
                self.hideProgressView()
            }
           
        }
        
        viewModel.requestFailureHandler.bind { (error) in
               self.hideProgressView()
               self.showErrorAlertWithTitle(AppConstants.errorTitle, message: AppConstants.errorMessageToGetContacts)
        }
    }
    
    
    
}

//MARK: TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return viewModel.contactNamesDictionary.keys.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            let letter = indexLettersInContactsArray[section]

            if let names = viewModel.contactNamesDictionary[letter] {
                return names.count
            }
    
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactsCell
    
        let letter = indexLettersInContactsArray[indexPath.section]
        
        if let names = viewModel.contactNamesDictionary[letter] {
            
            cell.populateData(contactDetails: names[indexPath.row])

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let letter = indexLettersInContactsArray[indexPath.section]
        
        if let names = viewModel.contactNamesDictionary[letter] {
            
            let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDetailVC") as! ProfileDetailVC
            ctrl.contactModel = names[indexPath.row]
            navigationController?.pushViewController(ctrl, animated: true)
            
        }
       
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return indexLettersInContactsArray[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return indexLetters
    }
}



