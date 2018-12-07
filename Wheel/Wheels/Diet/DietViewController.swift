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
    
    var background: UIView!
    
    // MARK: - Dependencies
    
    private var settings: SWDietSettingsRepository!
    
    private var settingsVm: SWDietSettingsViewModelRepository!
    
    // MARK: - Subviews
    
    private var radius: CGFloat = 120
    private var pieChart: SWNewPieViewController!
    
    private var size: CGSize = CGSize(width: 80, height: 200)
    private var slider: SWSliderViewController!

    private var shroud: UIView!
    
    // MARK: - Constants
    
    private let maxDailyEnergyIntake: Double = 3000
    
    private let maxDailyEnergyIntakeColor: UIColor = UIColor.froly
    
    private let minDailyEnergyIntakeColor: UIColor = UIColor.cornflowerblue
    
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
//            self.view.addGestureRecognizer(self.swiper)
            self.swiper.addTarget(self, action: #selector(onSwipe(sender:)))
            self.swiper.delegate = self
        }
        
        do {
            self.view.addSubview(self.background)
            self.background.frame = self.view.bounds
            
            self.shroud = UIView(frame: view.bounds)
            self.shroud.backgroundColor = UIColor.limedSpruce
            self.shroud.alpha = 0.8
            self.view.addSubview(shroud)
        }
        
        do {
            self.pieChart = SWNewPieViewController()
            do {
                self.pieChart.assembler = self.assembler.resolve()
                let diet = self.settings.get()
                self.pieChart.settings = diet
                self.pieChart.settingsVm = self.settingsVm.get(by: diet.id)
                self.pieChart.radius = self.radius
            }
            //            concreteSelectionController.delegate = self
            self.pieChart.view.frame = CGRect(origin: .zero, size: CGSize(side: self.radius * 2))
            self.pieChart.view.center = CGPoint(x: self.view.getBoundsCenter().x, y: self.view.bounds.height * 0.333)
            view.addSubview(self.pieChart.view)
            self.addChildViewController(self.pieChart)
            self.pieChart.didMove(toParentViewController: self)
            self.pieChart.alignSubviews()
            self.pieChart.hide()
        }
        
        do {
            self.slider = SWSliderViewController()
            self.slider.delegate = self
            self.slider.progress = self.settings.get().dailyEnergyIntake / self.maxDailyEnergyIntake
            self.slider.view.frame = CGRect(origin: .zero, size: self.size)
            self.slider.view.center = CGPoint(x: self.view.bounds.width * 0.333 * 0.5, y: self.view.bounds.height * 0.75)
            view.addSubview(self.slider.view)
            self.addChildViewController(self.slider)
            self.slider.didMove(toParentViewController: self)
            self.slider.alignSubviews()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pieChart.appear()
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let prev = settings.get()
        let next = SWDietSettings(
            id: prev.id,
            fatsDailyShare: pieChart.settings?.fatsDailyShare ?? prev.fatsDailyShare,
            proteinsDailyShare: pieChart.settings?.proteinsDailyShare ?? prev.proteinsDailyShare,
            carbohydratesDailyShare: pieChart.settings?.carbohydratesDailyShare ?? prev.carbohydratesDailyShare,
            morningEnergyIntakeShare: prev.morningEnergyIntakeShare,
            middayEnergyIntakeShare: prev.middayEnergyIntakeShare,
            eveningEnergyIntakeShare: prev.eveningEnergyIntakeShare,
            dailyEnergyIntake: self.slider.progress * self.maxDailyEnergyIntake,
            morning: prev.morning,
            midday: prev.midday,
            evening: prev.evening)
        settings.upsert(next)
        if let value = pieChart.settingsVm {
            settingsVm.upsert(value)
        }
    }
    
    // MARK: - Animation
    
    func set() {
        self.shroud.alpha = 0
    }
    
    func open() {
        self.shroud.alpha = 0.8
    }
}

extension DietViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        do {
            let location = gestureRecognizer.location(in: self.pieChart.view)
            print("bounds \(self.slider.view.bounds) point \(location)")
            let center = self.pieChart.view.getBoundsCenter()
            if otherGestureRecognizer === self.pieChart.spinner && (location.x - center.x).square() + (location.y - center.y).square() <= self.radius.square() {
                return true
            }
        }
        
        do {
            let location = gestureRecognizer.location(in: self.slider.view)
            print("bounds \(self.slider.view.bounds) point \(location)")
            if otherGestureRecognizer === self.slider.slider && location.x >= 0 && location.x <= self.slider.view.bounds.width && location.y >= 0 && location.y <= self.slider.view.bounds.height {
                return true
            }
        }
        
        return false
    }
    
}

extension DietViewController : SWSliderViewDelegate {
    
    func onUpdate(of progress: Double) {
        
    }
    

    func getColor(for progress: Double) -> UIColor {
        let max = self.maxDailyEnergyIntakeColor.cgColor.components ?? [0, 0, 0, 0]
        let min = self.minDailyEnergyIntakeColor.cgColor.components ?? [0, 0, 0, 0]
        let color = UIColor(
            red: (max[0] - min[0]) * CGFloat(progress) + min[0],
            green: (max[1] - min[1]) * CGFloat(progress) + min[1],
            blue: (max[2] - min[2]) * CGFloat(progress) + min[2],
            alpha: (max[3] - min[3]) * CGFloat(progress) + min[3])
        return color
    }
    
    
}
