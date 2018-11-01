//
//  SWHistoryCellAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 29/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWHistoryCellAligner {
    
    func generateView(for recipy: SWRecipy) -> (name: UILabel, stats: [UIView], like: UIButton, delete: UIButton, timestamp: UILabel)
    
    func calculatePositions(for views: (name: UILabel, stats: [UIView], like: UIButton, delete: UIButton, timestamp: UILabel), width: CGFloat) -> (centerOfName: CGPoint, centersOfStats: [CGPoint], centerOfLike: CGPoint, centerOfDelete: CGPoint, centerOfTimeStamp: CGPoint, height: CGFloat)

}
