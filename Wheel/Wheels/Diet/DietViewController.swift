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
    
    private var settingsVm: SWDietSettingsViewModelRepository!
    
    // MARK: - Subviews
    
    private var radius: CGFloat = 150
    private var pieChart: SWPieViewController!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.segues = assembler.resolve()
        
        self.settings = self.assembler.resolve()
        
        self.settingsVm = self.assembler.resolve()
        
        do {
            navigationItem.titleView = UILabel.dietTitle
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackClick(sender:))
            back.target = self
        }
        
        do {
            self.swiper = SWDismissHistoryGestureRecognizer()
            self.view.addGestureRecognizer(self.swiper)
            self.swiper.addTarget(self, action: #selector(onSwipe(sender:)))
            self.swiper.delegate = self
        }
        
        do {
            self.pieChart = SWPieViewController()
            do {
                self.pieChart.assembler = self.assembler.resolve()
                let diet = self.settings.get()
                self.pieChart.settings = diet
                self.pieChart.settingsVm = self.settingsVm.get(by: diet.id)
            }
            //            concreteSelectionController.delegate = self
            self.pieChart.view.frame = CGRect(origin: .zero, size: CGSize(side: self.radius * 2))
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
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        settings.upsert(pieChart.settings)
        if let value = pieChart.settingsVm {
            settingsVm.upsert(value)
        }
    }
}

extension DietViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        let location = gestureRecognizer.location(in: self.pieChart.view)
        let center = self.pieChart.view.getBoundsCenter()
        if otherGestureRecognizer === self.pieChart.spinner && (location.x - center.x).square() + (location.y - center.y).square() <= self.radius.square() {
            return true
        }
        else {
            return false
        }
    }
    
}
