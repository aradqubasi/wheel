//
//  SWConcreteHistoryCellAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 29/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWConcreteHistoryCellAligner: SWHistoryCellAligner {
    
    //MARK: - Dependencies
    
    private let width: CGFloat
    
    private let stringifier: SWDateStringifier
    
    //MARK: - Parameters
    
    private let margins = CGPoint(x: 16, y: 24)
    
    init(_ stringifier: SWDateStringifier, width: CGFloat) {
        self.stringifier = stringifier
        self.width = width
    }

    func generateView(for recipy: SWRecipy) -> (name: UILabel, stats: [UIView], like: UIButton, delete: UIButton, timestamp: UILabel, separator: UIView) {
        
        let name = UILabel()
        name.attributedText = NSAttributedString(string: recipy.name).avenirLightify(19).dovegraytify()
        name.frame = CGRect(origin: .zero, size: name.attributedText!.size())
        
        var stats: [UIView] = []
        
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
        timestamp.attributedText = NSAttributedString(string: self.stringifier.stringify(recipy.timestamp)).avenirLightify(16).dovegraytify()
        timestamp.frame = CGRect(origin: .zero, size: timestamp.attributedText!.size())
        
        let like = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 17, height: 15)))
        if recipy.liked {
            like.setImage(#imageLiteral(resourceName: "History/like"), for: .normal)
        }
        else {
            like.setImage(#imageLiteral(resourceName: "History/unlike"), for: .normal)
        }
        
        let separator = UIView().getRecipySeparatorLine(for: -self.margins.x + self.width + -self.margins.x)
        
        return (name, stats, like, UIButton(), timestamp, separator)
    }
    
    func calculatePositions(for views: (name: UILabel, stats: [UIView], like: UIButton, delete: UIButton, timestamp: UILabel, separator: UIView)) -> (centerOfName: CGPoint, centersOfStats: [CGPoint], centerOfLike: CGPoint, centerOfDelete: CGPoint, centerOfTimeStamp: CGPoint, centerOfSeparator: CGPoint, height: CGFloat) {
        
        let spacing: CGFloat = 8
        var offset: CGFloat = 16
        let high = margins.y + views.name.frame.height * 0.5
        let center = margins.y + views.name.frame.height + spacing + (views.stats.map({ $0.frame.height }).max() ?? 16) * 0.5
        let low = margins.y + views.name.frame.height + spacing + (views.stats.map({ $0.frame.height }).max() ?? 16) + spacing + views.timestamp.frame.height * 0.5
        let bottom = low + views.timestamp.frame.height * 0.5 + margins.y + views.separator.frame.height * 0.5
        let height = bottom + views.separator.frame.height * 0.5
        
        return (
            centerOfName: CGPoint(x: 16 + views.name.frame.width * 0.5, y: high),
            centersOfStats: views.stats.map({
                (next) -> CGPoint in
                let center = CGPoint(x: offset + next.frame.width * 0.5, y: center)
                offset += next.frame.width
                return center
            }),
            centerOfLike: CGPoint(x: width - 16 - views.like.frame.width, y: center),
            centerOfDelete: CGPoint(),
            centerOfTimeStamp: CGPoint(x: 16 + views.timestamp.frame.width * 0.5, y: low),
            centerOfSeparator: CGPoint(x: width * 0.5, y: bottom),
            height)
    }
}
