//
//  KeywordsTableViewController.swift
//  MapDemo
//
//  Created by Julian Tejera on 5/14/15.
//  Copyright (c) 2015 Julian Tejera. All rights reserved.
//

import UIKit

class KeywordsTableViewController: UITableViewController {

    var keywords = ["Restaurant", "Gas", "School", "Library", "Gym", "Theater", "Real Estate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keywords.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KeywordCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = keywords[indexPath.row]

        return cell
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapSegue" {
            if let controller = segue.destinationViewController.contentViewController as? MapViewController, cell = sender as? UITableViewCell, indexPath = tableView.indexPathForCell(cell) {
                controller.keyword = keywords[indexPath.row]
            }
        }
    }


}
