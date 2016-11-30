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
    
    let labels:[String] = ["ID","Parent ID","Chamber","Office","Contact"]
    var details:[String?] = []
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = text
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commDetailsCell", for: indexPath) as! legisDetailsCell
        cell.labels?.text = labels[indexPath.row] // set this as headers
        cell.data.text = details[indexPath.row]
        
        return cell
    }
    
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
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
