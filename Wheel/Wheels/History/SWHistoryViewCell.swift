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
    
    func setRecipy(_ recipy: SWRecipy, _ stringifier: SWDateStringifier) {
        
        do {
            let name = UILabel()
            name.attributedText = NSAttributedString(string: recipy.name).avenirLightify(19).dovegraytify()
            name.frame = CGRect(origin: .zero, size: name.attributedText!.size())
            
            let calories = UILabel()
            calories.setRecipySubheader("\(Int(recipy.calories)) kcals")
            stats.append(calories)
            
            let delimeter1 = UILabel.recipySubtitleOval
            stats.append(delimeter1)
            
            let carbohydrates = UILabel()
            carbohydrates.setRecipySubheader("\(Int(recipy.carbohydrates))g Carbs")
            stats.append(carbohydrates)
            
            let delimeter2 = UILabel.recipySubtitleOval
            stats.append(delimeter2)
            
            let fats = UILabel()
            fats.setRecipySubheader("\(Int(recipy.fats))g Fat")
            stats.append(fats)
            
            let delimeter3 = UILabel.recipySubtitleOval
            stats.append(delimeter3)
            
            let proteins = UILabel()
            proteins.setRecipySubheader("\(Int(recipy.proteins))g Proteins")
            stats.append(proteins)
            
            let timestamp = UILabel()
            timestamp.attributedText = NSAttributedString(string: stringifier.stringify(recipy.timestamp)).avenirLightify(16).dovegraytify()
            timestamp.frame = CGRect(origin: .zero, size: timestamp.attributedText!.size())
            
            let like = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 17, height: 15)))
            like.setImage(#imageLiteral(resourceName: "History/like"), for: .normal)
            
            var offset: CGFloat = 16
            let high = self.contentView.bounds.height * 0.333 * 0.5
            let center = self.contentView.bounds.height * 0.5
            let low = self.contentView.bounds.height * (0.333 * 2 + 0.333 * 0.5)
            
            self.contentView.addSubview(name)
            name.center = CGPoint(x: 16 + name.frame.width * 0.5,
                                  y: high)

            for view in stats {
                self.contentView.addSubview(view)
                view.center = CGPoint(x: offset + view.frame.width * 0.5,
                                      y: center)
                offset += view.frame.width
            }
            
            self.contentView.addSubview(like)
            like.center = CGPoint(x: self.contentView.bounds.width - 16 - like.frame.width,
                                  y: center)
            
            self.contentView.addSubview(timestamp)
            timestamp.center = CGPoint(x: 16 + timestamp.frame.width * 0.5,
                                       y: low)
            
        }
        
    }

}
