//
//  InsertTableViewCell.swift
//  FamConnects
//
//  Created by Brianna R on 8/3/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import UIKit

class InsertTableViewCell: UITableViewCell {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var sex: UITextField!
    var id: Int!
    
    let model = AncestorsModel()
    var delegate:RefreshDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func update(_ sender: Any) {
        let param = ["first_name": self.firstName.text!, "last_name": self.lastName.text!, "birth_year": self.birthDate.text!, "birth_place": self.state.text!, "id": id!] as [String : Any]
        
        model.updateAncestor(parameters: param, url: URLServices.updateAncestors) { (res) in
            if (res) {
                print("updated ancestor")
                self.delegate?.refresh()
            }
        }
    }
    
    @IBAction func deleteEntry(_ sender: Any) {
        let param = ["id": id!] as [String : Any]
        
        model.deleteAncestor(parameters: param, url: URLServices.deleteAncestors) { (result) in
            if (result) {
                print(result)
                self.delegate?.refresh()
            }
        }
    }
}
