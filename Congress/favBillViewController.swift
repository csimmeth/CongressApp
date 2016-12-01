//
//  favBillViewController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/30/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class favBillViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    var numLegislators = 0;
    var currentSelection:Int = 0
    var favBDict = [String: [String?]]()
    var keyArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard;
        
        favBDict = defaults.object(forKey: "favBills") as! [String:[String?]]
        numLegislators = favBDict.count
        keyArray = Array(favBDict.keys)
        keyArray = keyArray.sorted{
            return $0 < $1
        }
        
        // Do any additional setup after loading the view, typically from a nib.p
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let current_index:Int = indexPath.row
        //let current = favBDict[keyArray[current_index]]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favBillsCell", for: indexPath) as! FavBillCell
        
        cell.billText.text = keyArray[current_index]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyArray.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelection = indexPath.row
        performSegue(withIdentifier: "favBillSegue", sender: Any?.self) //TODO name segue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         if(segue.identifier != "menu" ){
         let detail:billDetailController = segue.destination as! billDetailController
            
         detail.details = favBDict[keyArray[currentSelection]]!
         detail.text = keyArray[currentSelection]
        }
        
    }
}
