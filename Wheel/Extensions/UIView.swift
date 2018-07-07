//
//  UIView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var toLayerView: UIView {
        get {
            let r = self.frame.width / 2
            self.backgroundColor = UIColor.white
            self.layer.cornerRadius = r
            self.layer.borderColor = UIColor.mystic.cgColor
            self.layer.borderWidth = 1
            self.layer.shadowColor = UIColor.aztec.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: -4, height: 0)
            self.layer.shadowRadius = 12
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: r).cgPath
            return self
        }
    }

    // MARK: - Methods
    
    func attach(_ view: UIView) -> UIView {
        self.addSubview(view)
        return view
    }
    
    func addSizeConstraints() {
//        translatesAutoresizingMaskIntoConstraints = false
        if let widthConstraint = self.constraints.first(where: { $0.firstAttribute == NSLayoutAttribute.width }) {
            self.removeConstraint(widthConstraint)
        }
        
        if let heightConstraint = self.constraints.first(where: { $0.firstAttribute == NSLayoutAttribute.height }) {
            self.removeConstraint(heightConstraint)
        }
        
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    }
    
    func addHeightConstraints() {

        if let heightConstraint = self.constraints.first(where: { $0.firstAttribute == NSLayoutAttribute.height }) {
            self.removeConstraint(heightConstraint)
        }
        
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    }

    func addCenterBottomConstraints() {
        guard let superview = superview else {
            fatalError("view is not attached to superview")
        }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func addBoundsConstraints() {
        guard let superview = superview else {
            fatalError("view is not attached to superview")
        }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Properties
    
    var radius: CGFloat {
        get {
            return max(frame.width, frame.height)
        }
    }
    
    var scale: CGFloat {
        get {
            return sqrt(CGFloat(transform.a * transform.a + transform.c * transform.c))
        }
    }
    
    // MARK: - Helpers
    
    class var bowlSun: UIView {
        get {
            let sun = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 91)))
            let r = sun.frame.width / 2
            sun.backgroundColor = UIColor.candlelight
            sun.layer.cornerRadius = r
            sun.layer.borderColor = UIColor.candlelight.cgColor
            sun.layer.borderWidth = 1
            sun.layer.shadowColor = UIColor.candlelight.cgColor
            sun.layer.shadowOpacity = 1
            sun.layer.shadowOffset = .zero
            sun.layer.shadowRadius = 52
            sun.layer.shadowPath = UIBezierPath(roundedRect: sun.bounds.insetBy(dx: -41, dy: -41), cornerRadius: r + 41).cgPath
            return sun
        }
    }
    
    class var recipySubtitleOval: UIView {
        get {
            let oval = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 3)))
            oval.backgroundColor = .porcelain
            oval.layer.cornerRadius = 1.5
            return oval
        }
    }
    
    func getRecipySeparatorLine(for width: CGFloat) -> UIView {
        let line = UIView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 2)))
//        line.layer.borderColor = UIColor(patternImage: UIImage.dash_pattern).cgColor
        line.backgroundColor = UIColor(patternImage: UIImage.dash_pattern)
        return line
    }
    
    func getBoundsCenter() -> CGPoint {
        return CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height * 0.5)
    }
    
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func shapeAsLayerView() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderColor = UIColor.mystic.cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.aztec.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: -4, height: 0)
        self.layer.shadowRadius = 12
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.width / 2).cgPath
    }

}
