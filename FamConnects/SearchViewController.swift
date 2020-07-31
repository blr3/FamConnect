//
//  SearchViewController.swift
//  FamConnect
//
//  Created by Brianna R on 7/29/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var checkToggle: UISwitch!
    @IBOutlet weak var check: UISegmentedControl!
    
    var modeldata: [Ancestor]?
    let model = AncestorsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
    }
    
    @IBAction func search(_ sender: Any) {
        let param0 = ["first_name": self.firstName.text!, "last_name": self.lastName.text!, "birth_date": self.birthDate.text!, "birth_place": self.state.text!, "checkbox": String(self.checkToggle.isOn)] as [String : Any]
        
        model.downloadAncestors(parameters: param0, url: URLServices.ancestors) { (res) in
            if (res) {
                DispatchQueue.main.sync {
                    self.performSegue(withIdentifier: "resId", sender: self)
                }
            }
        }
        
    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "resId" {
            let result = segue.destination as! ResultsViewController
            result.model = modeldata
        }
    }
    
}

extension SearchViewController: Downloadable {
    // implements our Downloadable protocol
    func didReceiveData(data: Any) {
       DispatchQueue.main.sync {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let results = storyboard.instantiateViewController(withIdentifier: "resultsID") as! ResultsViewController
            modeldata = (data as! [Ancestor])
//            self.present(results, animated: true, completion: nil)
        }
    }
}
