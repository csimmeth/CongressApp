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
    
    
    var numLegislators = 0;
    var currentSelection:Int = 0
    var favBDict = [String: [String?]]()
    var keyArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard;
        
        favBDict = defaults.object(forKey: "favBills") as! [String:[String?]]
        favBDict["Test Name"] = ["Bill ID","Bill Type"]
        
        //numLegislators = favLegislators.count
        numLegislators = favBDict.count
        keyArray = Array(favBDict.keys)
        
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
        
        //cell.bill_id.text = current?[0]!
        cell.billText.text = keyArray[current_index]
        //cell.billDate.text = current?[1]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numLegislators
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelection = indexPath.row
        //performSegue(withIdentifier: "detailsSSegue", sender: Any?.self) //TODO name segue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
         if(segue.identifier != "menu" ){
         let detail:DetailController = segue.destination as! DetailController
         //Set data of congressmen here for detailcontroller to use
         let person:JSON = legislators[currentSelection]
         
         var fax_string:String? = "N/A"
         var twitter_id:String? = "N/A"
         var facebook_id:String? = "N/A"
         var website:String? = "N/A"
         
         if let temp = person["fax"].string {
         fax_string = temp
         }
         if let temp = person["twitter_id"].string {
         twitter_id = "https://twitter.com/\(temp)"
         }
         if let temp = person["facebook_id"].string {
         facebook_id = "https://facebook.com/\(temp)"
         }
         if let temp = person["website"].string {
         website = temp
         }
         
         detail.details = [person["first_name"].string,
         person["last_name"].string,
         person["state_name"].string,
         person["gender"].string,
         person["birthday"].string,
         person["chamber"].string,
         fax_string,
         twitter_id,
         facebook_id,
         website,
         person["term_end"].string]
         detail.id = person["bioguide_id"].string!
         }
         */
    }
}
