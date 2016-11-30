//
//  DetailController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/28/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import TTTAttributedLabel
class DetailController: UIViewController, UITableViewDataSource,TTTAttributedLabelDelegate {
    
    @IBOutlet weak var legisImage: UIImageView!
    @IBOutlet weak var favSwitch: UISwitch!
    
    
    let labels:[String] = ["First Name","Last Name","State","Gender","Birth date","Chamber","Fax No.","Twitter","Facebook","Website","Office","End Term"]
    var details:[String?] = []
    var text:String = ""
    var id:String = ""
    let links:[String] = ["Twitter Link","Facebook Link","Website Link"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO load details into table (just set array data?) Could do this in segue function

        let imgstring = "https://theunitedstates.io/images/congress/original/\(id).jpg"
        let url = URL(string: imgstring)
        let data = try? Data(contentsOf: url!)
        legisImage.image = UIImage(data: data!)
        
        let defaults = UserDefaults.standard;
        var favLDict = [String:[String?]]()
        favLDict = defaults.object(forKey: "favLegislators") as! [String:[String?]]
        if favLDict[id] != nil {
            favSwitch.setOn(true, animated: false)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! legisDetailsCell
        cell.labels?.text = labels[indexPath.row] // set this as headers
        cell.data.text = details[indexPath.row]
        if(indexPath.row > 6 && indexPath.row < 10){
            let url_str:String = details[indexPath.row]!
            if(!(url_str == "N/A")){
                let str : NSString = links[indexPath.row - 7] as NSString
                cell.data.delegate = self
                cell.data.text = str as String
                let range : NSRange = str.range(of: str as String)
                cell.data.addLink(to: URL(string: url_str)!, with: range)
            }
        }
        return cell
    }
    
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    @IBAction func favoriteToggled(_ sender: UISwitch) {
        let defaults = UserDefaults.standard;
        var favLDict = [String:[String?]]()
        
        favLDict = defaults.object(forKey: "favLegislators") as! [String:[String?]]
        
        if(sender.isOn)
        {
            favLDict[id] = details
        } else {
            favLDict[id] = nil
        }
        defaults.set(favLDict,forKey: "favLegislators")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
