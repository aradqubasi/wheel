//
//  SWHistoryViewCell.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWHistoryViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundView?.backgroundColor = [UIColor.red, UIColor.blue, UIColor.green].random()!
        
        print("!")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
