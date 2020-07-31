//
//  ReusltTableViewCell.swift
//  FamConnects
//
//  Created by Brianna R on 7/30/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import Foundation
import UIKit

class ResultCell: UITableViewCell {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var birthPlaceLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellContents(model: Ancestor) {
        self.fullNameLabel.text = model.fullName
        self.birthDateLabel.text = String(model.birthLikeDate)
        self.birthPlaceLabel.text = model.birthLikePlaceText
        self.sexLabel.text = model.sex
    }

}
