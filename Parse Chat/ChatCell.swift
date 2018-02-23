//
//  ChatCell.swift
//  Parse Chat
//
//  Created by Michelle Caplin on 2/22/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var message: UILabel!

    @IBOutlet weak var bubbleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        // Initialization code
        //print(message)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
