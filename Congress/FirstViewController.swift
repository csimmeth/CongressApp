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
import SDWebImage



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
        cell.textLabel?.text = "\(legislators[indexPath.row]["last_name"].string!), \(legislators[indexPath.row]["first_name"].string!)"
        cell.detailTextLabel?.text = legislators[indexPath.row]["state_name"].string!
        //cell.imageView?.sd_setImageWithURL(NSURL(string: "https://theunitedstates.io/images/congress/original/D000626.jpg")! as URL,placeholderImage:UIImage(named:"placeholder.png"))
        //cell.imageView?.sd_setImage(with: NSURL(string: "https://theunitedstates.io/images/congress/original/D000626.jpg")! as URL!)
        let id = legislators[indexPath.row]["bioguide_id"].string!
        let urlString = "https://theunitedstates.io/images/congress/original/\(id).jpg"
        
        
        //http://stackoverflow.com/questions/4962561/set-uiimageview-image-using-a-url
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data!)
            }
            }.resume()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numLegislators
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        currentSelection = indexPath.row
        performSegue(withIdentifier: "detailsSegue", sender: Any?.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        
        //person["twitter_id"].string!,
        //person["facebook_id"].string!,
        //person["website"].string!,
        //person["office"].string!,

    }
}

