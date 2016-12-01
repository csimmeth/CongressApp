//
//  favLegislatorsViewController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/30/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class favLegislatorsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    var numLegislators = 0;
    var currentSelection:Int = 0
    var favLDict = [String: [String?]]()
    var keyArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarItem.appearance()
        let attributes: [String: AnyObject] = [NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
        appearance.setTitleTextAttributes(attributes, for: .normal)

        
        let defaults = UserDefaults.standard;
        
        favLDict = defaults.object(forKey: "favLegislators") as! [String:[String?]]
        
        //numLegislators = favLegislators.count
        numLegislators = favLDict.count
        keyArray = Array(favLDict.keys)
        
        // Do any additional setup after loading the view, typically from a nib.p
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let current_index:Int = indexPath.row
        let current = favLDict[keyArray[current_index]]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favLegislatorsCell", for: indexPath)
       
        cell.textLabel?.text = "\(current![1]!), \(current![0]!)"
        cell.detailTextLabel?.text = current![2]!
        
        let id = keyArray[current_index]
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
        performSegue(withIdentifier: "favLegisSegue", sender: Any?.self) //TODO name segue
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier != "menu" ){
            let detail:DetailController = segue.destination as! DetailController
            
            detail.details = favLDict[keyArray[currentSelection]]!
            detail.id = keyArray[currentSelection]
        }
 
    }
}
