//
//  legisDetailsCell.swift
//  Congress
//
//  Created by Caleb Simmeth on 11/29/16.
//  Copyright © 2016 Abdominal Snowmen. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class legisDetailsCell: UITableViewCell {

    @IBOutlet weak var labels: UILabel!
    @IBOutlet weak var data: TTTAttributedLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
