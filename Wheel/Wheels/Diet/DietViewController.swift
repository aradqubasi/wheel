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
    
    private let size = CGSize(width: 70, height: 200)
    private var slider: SWSliderViewController!
    
    private let buttonSize = CGSize(side: 70)
    private var gluten: UIButton!
    private var meat: UIButton!
    private var fish: UIButton!
    private var dairy: UIButton!

    private var shroud: UIView!
    
    private var calories: UILabel!
    private var kkcals: UILabel!
    private var heart: UIView!
    
    private var heartbeat: Timer!
    private var ticks: Int = 1
    
    // MARK: - Private Variables
    
    private var allowGluten: Bool!
    private var allowFish: Bool!
    private var allowMeat: Bool!
    private var allowDairy: Bool!
    
    
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

        let positions = (
            piechart: CGPoint(
                x: self.view.getBoundsCenter().x,
                y: self.view.getBoundsCenter().y - 109),
            slider: CGPoint(
                x: self.view.getBoundsCenter().x - 96,
                y: self.view.getBoundsCenter().y + 145),
            gluten: CGPoint(
                x: self.view.getBoundsCenter().x + 60 - 8 - 35,
                y: self.view.getBoundsCenter().y + 142 - 8 - 35),
            meat: CGPoint(
                x: self.view.getBoundsCenter().x + 60 + 8 + 35,
                y: self.view.getBoundsCenter().y + 142 - 8 - 35),
            fish: CGPoint(
                x: self.view.getBoundsCenter().x + 60 + 8 + 35,
                y: self.view.getBoundsCenter().y + 142 + 8 + 35),
            dairy: CGPoint(
                x: self.view.getBoundsCenter().x + 60 - 8 - 35,
                y: self.view.getBoundsCenter().y + 142 + 8 + 35)
        )
        
        do {
            self.pieChart = SWNewPieViewController()
            do {
                self.pieChart.assembler = self.assembler.resolve()
                let diet = self.settings.get()
                self.pieChart.settings = diet
                self.pieChart.settingsVm = self.settingsVm.get(by: diet.id)
                self.pieChart.radius = self.radius
            }
            self.pieChart.view.frame = CGRect(origin: .zero, size: CGSize(side: self.radius * 2))
            self.pieChart.view.center = positions.piechart
            //            self.pieChart.view.center = CGPoint(x: self.view.getBoundsCenter().x, y: self.view.bounds.height * 0.333)
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
            self.slider.view.center = positions.slider
//            self.slider.view.center = CGPoint(x: self.view.bounds.width * 0.333 * 0.5, y: self.view.bounds.height * 0.75)
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
            self.heart = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 14)))
            self.view.addSubview(self.heart)
            self.heart.center = CGPoint(x: self.slider.view.center.x, y: self.slider.view.center.y + self.slider.view.frame.height * 0.5 - self.heart.frame.height * 0.5 - self.slider.view.frame.width * 0.2)
            let layer = CAShapeLayer()
            self.heart.layer.addSublayer(layer)
            layer.fillColor = UIColor.limedSpruce.cgColor
            layer.path = self.drawHeart(at: self.heart.getBoundsCenter())
        }
        
        let period = 0.3
        do {
            self.heartbeat = Timer.scheduledTimer(withTimeInterval: period, repeats: true, block: {
                _ in
//                print(self.ticks)
                var beat = false
                if self.slider.progress < 0.4 && self.ticks >= 3 {
                    beat = true
                }
                else if self.slider.progress >= 0.4 && self.slider.progress < 0.666 && self.ticks >= 2 {
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
//            let groupCenter = CGPoint(x: self.view.center.x * 1.5, y: self.view.center.y * 1.5)
            
            self.gluten = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.gluten.setImage(#imageLiteral(resourceName: "diet/gluten"), for: .normal)
            self.gluten.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
            self.gluten.addTarget(self, action: #selector(onGlutenClick(sender:)), for: .touchUpInside)
            self.gluten.backgroundColor = UIColor.limedSpruce
            self.gluten.center = positions.gluten
            self.gluten.layer.cornerRadius = self.gluten.frame.width * 0.2
            self.view.addSubview(self.gluten)
            
            self.meat = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.meat.setImage(#imageLiteral(resourceName: "diet/meat"), for: .normal)
            self.meat.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
            self.meat.addTarget(self, action: #selector(onMeatClick(sender:)), for: .touchUpInside)
            self.meat.backgroundColor = UIColor.limedSpruce
            self.meat.center = positions.meat
            self.meat.layer.cornerRadius = self.meat.frame.width * 0.2
            self.view.addSubview(self.meat)
            
            self.fish = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.fish.setImage(#imageLiteral(resourceName: "diet/fish"), for: .normal)
            self.fish.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
            self.fish.addTarget(self, action: #selector(onFishClick(sender:)), for: .touchUpInside)
            self.fish.backgroundColor = UIColor.limedSpruce
            self.fish.center = positions.fish
            self.fish.layer.cornerRadius = self.fish.frame.width * 0.2
            self.view.addSubview(self.fish)
            
            self.dairy = UIButton(frame: CGRect(origin: .zero, size: self.buttonSize))
            self.dairy.setImage(#imageLiteral(resourceName: "diet/dairy"), for: .normal)
            self.dairy.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
            self.dairy.addTarget(self, action: #selector(onDairyClick(sender:)), for: .touchUpInside)
            self.dairy.backgroundColor = UIColor.limedSpruce
            self.dairy.center = positions.dairy
            self.dairy.layer.cornerRadius = self.dairy.frame.width * 0.2
            self.view.addSubview(self.dairy)
        }
        
        do {
            self.allowGluten = false
            self.allowFish = false
            self.allowMeat = false
            self.allowDairy = false
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
    
    private func drawHeart(at center: CGPoint) -> CGPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 7) + center)
        
        path.addCurve(
            to: CGPoint(x: -0.39, y: 6.84) + center,
            controlPoint1: CGPoint(x: -0.14, y: 7) + center,
            controlPoint2: CGPoint(x: -0.28, y: 6.95) + center)
        
        path.addLine(to: CGPoint(x: -6.63, y: 0.97) + center)
        
        path.addCurve(
            to: CGPoint(x: -6.63, y: -5.64) + center,
            controlPoint1: CGPoint(x: -8.46, y: -0.85) + center,
            controlPoint2: CGPoint(x: -8.46, y: -3.83) + center)
        
        path.addCurve(
            to: CGPoint(x: -3.32, y: -7) + center,
            controlPoint1: CGPoint(x: -5.72, y: -6.55) + center,
            controlPoint2: CGPoint(x: -4.52, y: -7) + center)
        
        path.addCurve(
            to: CGPoint(x: -0.03, y: -5.29) + center,
            controlPoint1: CGPoint(x: -2.12, y: -7) + center,
            controlPoint2: CGPoint(x: -0.94, y: -6.14) + center)
        
        path.addLine(to: CGPoint(x: 0.04, y: -5.29) + center) // \/
        
        path.addCurve(
            to: CGPoint(x: 3.71, y: -6.82) + center,
            controlPoint1: CGPoint(x: 1.04, y: -6.27) + center,
            controlPoint2: CGPoint(x: 2.4, y: -6.82) + center)
        
        path.addCurve(
            to: CGPoint(x: 6.64, y: -5.64) + center,
            controlPoint1: CGPoint(x: 4.78, y: -6.82) + center,
            controlPoint2: CGPoint(x: 5.82, y: -6.46) + center)
        
        path.addCurve(
            to: CGPoint(x: 8, y: -2.33) + center,
            controlPoint1: CGPoint(x: 7.55, y: -4.74) + center,
            controlPoint2: CGPoint(x: 8.02, y: -3.54) + center)
        
        path.addCurve(
            to: CGPoint(x: 6.64, y: 0.97) + center,
            controlPoint1: CGPoint(x: 8, y: -1.13) + center,
            controlPoint2: CGPoint(x: 7.55, y: 0.06) + center)
        
        path.addLine(to: CGPoint(x: 0.4, y: 6.84) + center)
        
        path.addCurve(
            to: CGPoint(x: 0, y: 7) + center,
            controlPoint1: CGPoint(x: 0.29, y: 6.95) + center,
            controlPoint2: CGPoint(x: 0.15, y: 7) + center)
        
        path.close()
        return path.cgPath
    }
    
    @IBAction private func onGlutenClick(sender: UIButton) {
        self.allowGluten = !self.allowGluten
        if (self.allowGluten) {
            self.gluten.backgroundColor = .sandrift
        }
        else {
            self.gluten.backgroundColor = .limedSpruce
        }
    }
    
    @IBAction private func onFishClick(sender: UIButton) {
        self.allowFish = !self.allowFish
        if (self.allowFish) {
            self.fish.backgroundColor = .wildblueyonder
        }
        else {
            self.fish.backgroundColor = .limedSpruce
        }
    }
    
    @IBAction private func onMeatClick(sender: UIButton) {
        self.allowMeat = !self.allowMeat
        if (self.allowMeat) {
            self.meat.backgroundColor = .turkishrose
        }
        else {
            self.meat.backgroundColor = .limedSpruce
        }
    }
    
    @IBAction private func onDairyClick(sender: UIButton) {
        self.allowDairy = !self.allowDairy
        if (self.allowDairy) {
            self.dairy.backgroundColor = .lavenderpurple
        }
        else {
            self.dairy.backgroundColor = .limedSpruce
        }
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
