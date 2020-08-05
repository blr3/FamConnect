//
//  ResultsViewController.swift
//  FamConnects
//
//  Created by Brianna R on 7/30/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UITableViewController {
    
    var model: [Ancestor]?
    var ancestors: [Ancestor] = []
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    
    @IBAction func addBtn(_ sender: Any) {
//        ancestors.append(self.model[])
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = self.model else {
            return 0
        }
        return self.model!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCellID", for: indexPath) as! ResultCell
        let ancestor = self.model![indexPath.row]
        cell.setCellContents(model: ancestor)
        return cell
    }
}
