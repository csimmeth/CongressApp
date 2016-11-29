//
//  FirstViewController.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/28/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{

    let data:[[String]] = [["One","Two","Three"],["Four","Five","Six"],["Seven","Eight","Nine"]]
    var currentSelection:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        cell.textLabel?.text = data[0][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
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

