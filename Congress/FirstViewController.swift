//
//  FirstViewController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/28/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var legislatorsTableView: UITableView!

    var numLegislators = 0;
    var legislators:[JSON] = []
    let data:[[String]] = [["One","Two","Three"],["Four","Five","Six"],["Seven","Eight","Nine"]]
    var currentSelection:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://hw811944.us-west-2.elasticbeanstalk.com/a8/index.php?keyword=legislators"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.legislators = json["results"].arrayValue
                self.numLegislators = self.legislators.count
                print("JSON: \(self.numLegislators)")
                print(self.legislators[0]["first_name"].string!)
                self.legislatorsTableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        cell.textLabel?.text = legislators[indexPath.row]["first_name"].string!
        print("here")
        print(legislators[indexPath.row]["first_name"].string!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numLegislators
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("table selected")

        currentSelection = indexPath.row
        performSegue(withIdentifier: "detailsSegue", sender: Any?.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail:DetailController = segue.destination as! DetailController
        //Set data of congressmen here for detailcontroller to use
        
        print("setting string")
        detail.text = String(currentSelection)
        detail.details = data[currentSelection]
    }
}

