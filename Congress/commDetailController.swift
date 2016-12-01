//
//  commDetailController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/30/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import TTTAttributedLabel
class commDetailController: UIViewController, UITableViewDataSource,TTTAttributedLabelDelegate {
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var favSwitch: UISwitch!
    
    let labels:[String] = ["ID","Parent ID","Chamber","Office","Contact"]
    var details:[String?] = []
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = text
        
        let defaults = UserDefaults.standard;
        var favDict = [String:[String?]]()
        favDict = defaults.object(forKey: "favCommittees") as! [String:[String?]]
        if favDict[text] != nil {
            favSwitch.setOn(true, animated: false)
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commDetailsCell", for: indexPath) as! legisDetailsCell
        cell.labels?.text = labels[indexPath.row] // set this as headers
        
        if details[indexPath.row] == nil{
            details[indexPath.row] = "N/A"
        }
        cell.data.text = details[indexPath.row]
        
        return cell
    }
    
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        let defaults = UserDefaults.standard;
        var favDict = [String:[String?]]()
        
        favDict = defaults.object(forKey: "favCommittees") as! [String:[String?]]
        
        if(sender.isOn)
        {
            favDict[text] = details
        } else {
            favDict[text] = nil
        }
        defaults.set(favDict,forKey: "favCommittees")

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
