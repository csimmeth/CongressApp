//
//  billDetailController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/28/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import TTTAttributedLabel
class billDetailController: UIViewController, UITableViewDataSource,TTTAttributedLabelDelegate {
    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var favSwitch: UISwitch!
    let labels:[String] = ["Bill ID","Bill Type","Sponsor","Last Action","PDF","Chamber","Last Vote","Status"]
    var details:[String?] = []
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = text
        
        
        let defaults = UserDefaults.standard;
        var favDict = [String:[String?]]()
        favDict = defaults.object(forKey: "favBills") as! [String:[String?]]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "billDetailsCell", for: indexPath) as! legisDetailsCell
        cell.labels?.text = labels[indexPath.row] // set this as headers
        
        if details[indexPath.row] == nil{
            details[indexPath.row] = "N/A"
        }
        cell.data.text = details[indexPath.row]
        
        if(indexPath.row == 4){
            let url_str:String = details[indexPath.row]!
            if(!(url_str == "N/A")){
                let str : NSString = "PDF Link" as NSString
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
    
    @IBAction func favToggled(_ sender: UISwitch) {
        let defaults = UserDefaults.standard;
        var favDict = [String:[String?]]()
        
        favDict = defaults.object(forKey: "favBills") as! [String:[String?]]
        
        if(sender.isOn)
        {
            favDict[text] = details
        } else {
            favDict[text] = nil
        }
        defaults.set(favDict,forKey: "favBills")
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
