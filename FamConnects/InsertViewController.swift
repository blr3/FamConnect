//
//  InsertViewController.swift
//  FamConnects
//
//  Created by Brianna R on 7/30/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let model = AncestorsModel()
    var added = [Ancestor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: "InsertTableViewCell", bundle: Bundle(for: type(of: self)))
//        tableView.register(nib, forCellReuseIdentifier: "InsertTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        
        let param = ["first_name": "", "last_name": "", "birth_year": "", "birth_place": ""] as [String : Any]
        
        self.model.downloadAncestors(parameters: param, url: URLServices.getAncestors) { (res) in
            if (res) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @IBAction func addPerson(_ sender: Any) {
        let param = ["first_name": self.firstName.text!, "last_name": self.lastName.text!, "birth_year": self.birthDate.text!, "birth_place": self.state.text!] as [String : Any]
        
//        DispatchQueue.main.async {
            self.model.insertAncestors(parameters: param, url: URLServices.insertAncestors) { (res) in
                if (res) {
                    print("inserted ancestor")
                    // add the new person to the database and also to the relationship
//                    self.tableView.reloadData()
                }
            }
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return added.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // make sure query searches for entries that are not empty strings in this category or null
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InsertTableViewCell

        cell.firstName.text = self.added[indexPath.row].fullName
        // we should split full name into first and last name
        cell.sex.text = self.added[indexPath.row].sex
        cell.birthDate.text = String(self.added[indexPath.row].birthLikeDate)
        cell.state.text = self.added[indexPath.row].birthLikePlaceText
        cell.id = self.added[indexPath.row].pid
        return cell
    }
}

extension InsertViewController: Downloadable {
    // implements our Downloadable protocol
    func didReceiveData(data: Any) {
       DispatchQueue.main.sync {
            let temp = (data as! [Ancestor])
        
            for ancestor in temp {
                if ancestor.pid > 200 {
                    added.append(ancestor)
                }
            }
        }
    }
}
