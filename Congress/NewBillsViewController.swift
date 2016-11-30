//
//  ActiveBillsViewController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/30/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage



class NewBillsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var newTableView: UITableView!
    
    var numElements = 0;
    var bills:[JSON] = []
    let data:[[String]] = [["One","Two","Three"],["Four","Five","Six"],["Seven","Eight","Nine"]]
    var currentSelection:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        let attributes: [String: AnyObject] = [NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        let url = "http://hw811944.us-west-2.elasticbeanstalk.com/a8/index.php?keyword=newbills"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.bills = json["results"].arrayValue
                self.numElements = self.bills.count
                self.newTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let current_index:Int = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "newBillCell", for: indexPath) as! billCell
        cell.bill_id.text = bills[current_index]["bill_id"].string!
        cell.billText.text = bills[current_index]["official_title"].string!
        cell.billDate.text = bills[current_index]["introduced_on"].string!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numElements
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelection = indexPath.row
        performSegue(withIdentifier: "newBillDetailsSegue", sender: Any?.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier != "menu"){
            
            let detail:billDetailController = segue.destination as! billDetailController
            
            let bill_info:JSON = bills[currentSelection]
            
            let sponsor:String = "\(bill_info["sponsor"]["title"].string!) \(bill_info["sponsor"]["first_name"].string!) \(bill_info["sponsor"]["last_name"].string!)"
            let active = bill_info["history"]["active"].bool!
            var active_str = "Not Active"
            if(active){
                active_str = "Active"
            }
            
            var pdf_link:String? = "N/A"
            if let temp = bill_info["last_version"]["urls"]["pdf"].string {
                pdf_link = temp
            }
            detail.details = [bill_info["bill_id"].string,
                              bill_info["bill_type"].string,
                              sponsor,
                              bill_info["last_action_at"].string,
                              pdf_link,
                              bill_info["chamber"].string,
                              bill_info["last_vote_at"].string,
                              active_str]
            detail.text = bill_info["official_title"].string!
            
        }
    }
}
