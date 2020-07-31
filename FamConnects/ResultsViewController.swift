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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let _ = self.model else {
            return 0
        }
        return self.model!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCellID", for: indexPath) as! ResultCell
        let ancestor = self.model![indexPath.row]
        cell.setCellContents(model: ancestor)
        // Return the configured cell
        return cell
    }
}
