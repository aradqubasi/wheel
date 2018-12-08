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
    
    private let size = CGSize(width: 60, height: 200)
    private var slider: SWSliderViewController!
    
    private let buttonSize = CGSize(side: 60)
    private var gluten: UIButton!
    private var meat: UIButton!
    private var fish: UIButton!
    private var dairy: UIButton!

    private var shroud: UIView!
    
    private var calories: UILabel!
    private var kkcals: UILabel!
    private var heart: UIImageView!
    
    private var heartbeat: Timer!
    private var ticks: Int = 1
    
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
        
        do {
            self.calories = UILabel()
            self.view.addSubview(self.calories)
            self.kkcals = UILabel()
            self.view.addSubview(self.kkcals)
            self.printCalories(self.slider.progress)
            self.alignCalories()
        }
        
        do {
            self.heart = UIImageView(image: #imageLiteral(resourceName: "diet/heart"))
            self.view.addSubview(self.heart)
            self.heart.center = CGPoint(x: self.slider.view.center.x, y: self.slider.view.center.y + self.slider.view.frame.height * 0.5 - self.heart.frame.height * 0.5 - self.slider.view.frame.width * 0.2)
        }
        
        let period = 0.3
        do {
            self.heartbeat = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: {
                _ in
//                print(self.ticks)
                var beat = false
                if self.slider.progress < 0.333 && self.ticks >= 3 {
                    beat = true
                }
                else if self.slider.progress >= 0.333 && self.slider.progress < 0.666 && self.ticks >= 2 {
                    beat = true
                }
                else if self.slider.progress >= 0.666 && self.ticks >= 1 {
                    beat = true
                }
                
                if beat {
                    self.ticks = 0
                    UIView.animate(withDuration: period * 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                        self.heart.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
                    }, completion: {
                        (success) in
                        UIView.animate(withDuration: period * 0.75, animations: {
                            self.heart.transform = CGAffineTransform.identity
                        })
                    })
                }
                
                self.ticks += 1
            })
        }
        
        do {
//            let groupCenter = CGPoint(x: self.view.center.x + 10 + self.buttonSize.width + 5, y: self.view.center.y + 10 + self.buttonSize.height + 5)
            let groupCenter = CGPoint(x: self.view.center.x * 1.5, y: self.view.center.y * 1.5)
            
            self.gluten = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.gluten.backgroundColor = UIColor.limedSpruce
            self.gluten.center = CGPoint(x: groupCenter.x - 5 - self.buttonSize.width * 0.5, y: groupCenter.y - 5 - self.buttonSize.height * 0.5)
            self.view.addSubview(self.gluten)
            
            self.meat = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.meat.backgroundColor = UIColor.limedSpruce
            self.meat.center = CGPoint(x: groupCenter.x - 5 - self.buttonSize.width * 0.5, y: groupCenter.y + 5 + self.buttonSize.height * 0.5)
            self.view.addSubview(self.meat)
            
            self.fish = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.fish.backgroundColor = UIColor.limedSpruce
            self.fish.center = CGPoint(x: groupCenter.x + 5 + self.buttonSize.width * 0.5, y: groupCenter.y - 5 - self.buttonSize.height * 0.5)
            self.view.addSubview(self.fish)
            
            self.dairy = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.dairy.backgroundColor = UIColor.limedSpruce
            self.dairy.center = CGPoint(x: groupCenter.x + 5 + self.buttonSize.width * 0.5, y: groupCenter.y + 5 + self.buttonSize.height * 0.5)
            self.view.addSubview(self.dairy)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pieChart.appear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.heartbeat?.invalidate()
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
    
    private func printCalories(_ value: Double) {
        self.calories.attributedText = (NSAttributedString(string: String(describing: Int(value * self.maxDailyEnergyIntake)))).avenirHeavfy(24).whitify()
        self.kkcals.attributedText = (NSAttributedString(string: "kkcal")).avenirLightify(14).whitify()
    }
    
    private func alignCalories() {
        self.calories.frame.size = self.calories.attributedText?.size() ?? .zero
        self.calories.center = CGPoint(x: self.slider.view.center.x, y: self.slider.view.center.y + self.slider.view.frame.height * 0.5 + 5 + self.calories.frame.size.height * 0.5)
        self.kkcals.frame.size = self.kkcals.attributedText?.size() ?? .zero
        self.kkcals.center = CGPoint(x: self.calories.center.x, y: self.calories.center.y + self.calories.frame.height * 0.5 + self.kkcals.frame.height * 0.5)
    }
    
}

extension DietViewController : SWSliderViewDelegate {
    
    func onUpdate(of progress: Double) {
        self.printCalories(progress)
        self.alignCalories()
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
