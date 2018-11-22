//
//  DietViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class DietViewController: SWTransitioningViewController {
    
    // MARK: - Injection
    
    var assembler: SWDietAssembler!
    
    // MARK: - Dependencies
    
    private var settings: SWDietSettingsRepository!
    
    // MARK: - Subviews
    
    private var pieChart: SWPieViewController!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.segues = assembler.resolve()
        
        self.settings = self.assembler.resolve()
        
        do {
            navigationItem.titleView = UILabel.dietTitle
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackClick(sender:))
            back.target = self
        }
        
        do {
            self.swiper = SWDismissHistoryGestureRecognizer()
//            self.view.addGestureRecognizer(self.swiper)
            self.swiper.addTarget(self, action: #selector(onSwipe(sender:)))
            self.swiper.delegate = self
        }
        
        do {
            self.pieChart = SWPieViewController()
            do {
                self.pieChart.assembler = self.assembler.resolve()
                self.pieChart.settings = self.settings.get()
            }
            //            concreteSelectionController.delegate = self
            self.pieChart.view.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
            self.pieChart.view.center = self.view.getBoundsCenter()
            view.addSubview(self.pieChart.view)
            self.addChildViewController(self.pieChart)
            self.pieChart.didMove(toParentViewController: self)
            self.pieChart.alignSubviews()
            self.pieChart.hide()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pieChart.appear()
    }
    
}

extension DietViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.location(in: self.pieChart.view)
        let center = self.pieChart.view.getBoundsCenter()
        if gestureRecognizer === self.swiper && otherGestureRecognizer === self.pieChart.spinner && (location.x - center.x).square() + (location.y - center.y).square() <= CGFloat(100).square() {
            return true
        }
        else {
            return false
        }
    }
    
}
