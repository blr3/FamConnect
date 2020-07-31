//
//  InsertViewController.swift
//  FamConnects
//
//  Created by Brianna R on 7/30/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    
    let model = AncestorsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //model.delegate = self
    }

    @IBAction func addPerson(_ sender: Any) {
        let param0 = ["first_name": self.firstName.text!, "last_name": self.lastName.text!, "birth_date": self.birthDate.text!, "birth_place": self.state.text!]
        
        model.insertAncestors(parameters: param0, url: URLServices.ancestors) { (res) in
            if (res) {
                print("inserted ancestor")
            }
        }
    }
}
