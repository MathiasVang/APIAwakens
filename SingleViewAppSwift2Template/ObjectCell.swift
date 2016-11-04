//
//  ObjectCell.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 26/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ObjectCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var buttonTap: ((tag: Int, UITableViewCell) throws -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        button1.enabled = true
        button2.enabled = true
        
        button1.tag = 1
        button2.tag = 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapAction(sender: AnyObject) {
        try! buttonTap?(tag: (sender as! UIButton).tag, self)
    }
    

}
