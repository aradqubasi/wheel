//
//  SWHistoryViewCell.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWHistoryViewCell: UITableViewCell {
    
    private var name: UILabel?
    
    private var stats: [UIView] = []
    
    private var timestamp: UILabel?
    
    private var like: UIButton?
    
    private var delete: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRecipy(_ recipy: SWRecipy, _ aligner: SWHistoryCellAligner) {
        
        do {
            
            do {
                if let name = self.name {
                    name.removeFromSuperview()
                }
                if self.stats.count != 0 {
                    self.stats.forEach({ $0.removeFromSuperview() })
                }
                if let timestamp = self.timestamp {
                    timestamp.removeFromSuperview()
                }
                if let like = self.like {
                    like.removeFromSuperview()
                }
            }

            do {
                let views = aligner.generateView(for: recipy)
                
                self.name = views.name
                self.stats = views.stats
                self.timestamp = views.timestamp
                self.like = views.like
                
                self.contentView.addSubview(self.name!)
                self.stats.forEach({ self.contentView.addSubview($0) })
                self.contentView.addSubview(self.timestamp!)
                self.contentView.addSubview(self.like!)
                
                do {
                    let positions = aligner.calculatePositions(for: views, width: self.contentView.bounds.width)
                    self.name?.center = positions.centerOfName
                    for i in 0..<positions.centersOfStats.count {
                        self.stats[i].center = positions.centersOfStats[i]
                    }
                    self.timestamp?.center = positions.centerOfTimeStamp
                    self.like?.center = positions.centerOfLike
                }
            }

        }
        
    }

}
