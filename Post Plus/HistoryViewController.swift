//
//  HistoryViewController.swift
//  Post Plus
//
//  Created by Tech World on 16/8/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // View Declaration Variables Start:
    
    @IBOutlet weak var HistoryView: UITableView!
    
    // View Declaration Variables End --
    
    // Other Variables Start:
    
    let historyList = ["15 thAugust", "15 thAugust", "15th August", "15th August", "15th August", "15th August"]
    
    // Other Variables End --
    
    // Functions Start:
    
    // To return the number of Rows Present in the Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    // To Create cell for the Storing Items
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HistoryView.dequeueReusableCell(withIdentifier: "HistoryDetails", for: indexPath)
        cell.textLabel?.text = historyList[indexPath.row]
        
        return cell
        
    }
    
    // Functions End --

    /*
     // Resources Start:
     
     1. UITable View Basics: https://www.youtube.com/watch?v=bkeZ2u9kmdg
     
     // Resources End --
     
     */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
