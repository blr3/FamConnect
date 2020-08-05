//
//  InsertViewController.swift
//  FamConnects
//
//  Created by Brianna R on 7/30/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import UIKit

protocol RefreshDelegate {
    func refresh() 
}

class InsertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let model = AncestorsModel()
    var added = [Ancestor]()
    var ids = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        refresh()
    }
    
    func refresh() {
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

        self.model.insertAncestors(parameters: param, url: URLServices.insertAncestors) { (res) in
            if (res) {
                print("inserted ancestor")
                self.refresh()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return added.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InsertTableViewCell
        let components = self.added[indexPath.row].fullName?.split{ $0 == " " }
        cell.firstName.text = String(components?[0] ?? "")
        cell.lastName.text = String(components?[1] ?? "")
        cell.sex.text = self.added[indexPath.row].sex
        cell.birthDate.text = String(self.added[indexPath.row].birthLikeDate)
        cell.state.text = self.added[indexPath.row].birthLikePlaceText
        cell.id = self.added[indexPath.row].pid
        return cell
    }
}

extension InsertViewController: Downloadable {
    func didReceiveData(data: Any) {
       DispatchQueue.main.sync {
            let temp = (data as! [Ancestor])
    
            for ancestor in temp {
                if ancestor.pid > 200 && !ids.contains(ancestor.pid) {
                    added.append(ancestor)
                    ids.append(ancestor.pid)
                }
            }
        }
    }
}
