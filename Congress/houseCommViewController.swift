//
//  houseCommViewController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/30/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage



class houseCommViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var numElements = 0;
    var committees:[JSON] = []
    let data:[[String]] = [["One","Two","Three"],["Four","Five","Six"],["Seven","Eight","Nine"]]
    var currentSelection:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        let attributes: [String: AnyObject] = [NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        let url = "http://hw811944.us-west-2.elasticbeanstalk.com/a8/index.php?keyword=housec"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.committees = json["results"].arrayValue
                self.numElements = self.committees.count
                self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCommCell", for: indexPath)
        cell.textLabel?.text = committees[current_index]["name"].string!
        cell.detailTextLabel?.text = committees[current_index]["committee_id"].string!
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numElements
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelection = indexPath.row
        performSegue(withIdentifier: "houseCommSegue", sender: Any?.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier != "menu"){
            
            let detail:commDetailController = segue.destination as! commDetailController
            
            let comm_info:JSON = committees[currentSelection]
            
            
            var office:String = "N/A"
            var parent:String = "N/A"
            var chamber:String = "N/A"
            var contact:String = "N/A"
            
            if let temp = comm_info["office"].string {
                office = temp
            }
            if let temp = comm_info["parent_committee_id"].string {
                parent = temp
            }
            if let temp = comm_info["chamber"].string {
                chamber = temp
            }
            if let temp = comm_info["phone"].string {
                contact = temp
            }
            
            detail.details = [comm_info["committee_id"].string,
                              parent,
                              chamber,
                              office,
                              contact,
            ]
            detail.text = comm_info["name"].string!
           
        }
 
    }
}
