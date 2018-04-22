//
//  SWRecipyStatsView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWRecipyStatsView: UIStackView {
    
    // MARK: - Private Properties
    
    private var _enegryLabel: UILabel!
    
    private var _oval1: UIView!
    
    private var _carbohydratesLabel: UILabel!
    
    private var _oval2: UIView!
    
    private var _fatsLabel: UILabel!
    
    private var _oval3: UIView!
    
    private var _proteinsLabel: UILabel!
    
    private var _energy: Double!
    
    private let _energyUnit: String!
    
    private let _weightUnit: String!
    
    private var _carbohydrates: Double!
    
    private var _fats: Double!
    
    private var _proteins: Double!
    
    // MARK: - Initialization

    init(energyUnit: String, weightUnit: String) {
        
        self._energyUnit = energyUnit
        self._weightUnit = weightUnit
        
        _enegryLabel = UILabel()//.getRecipySubheader()
        _oval1 = UIView.recipySubtitleOval
        _carbohydratesLabel = UILabel()//.getRecipySubheader()
        _oval2 = UIView.recipySubtitleOval
        _fatsLabel = UILabel()//.getRecipySubheader()
        _oval3 = UIView.recipySubtitleOval
        _proteinsLabel = UILabel()//.getRecipySubheader()
        let filler = UIView()
        
        _enegryLabel.translatesAutoresizingMaskIntoConstraints = false
        _oval1.translatesAutoresizingMaskIntoConstraints = false
        _carbohydratesLabel.translatesAutoresizingMaskIntoConstraints = false
        _oval2.translatesAutoresizingMaskIntoConstraints = false
        _fatsLabel.translatesAutoresizingMaskIntoConstraints = false
        _oval3.translatesAutoresizingMaskIntoConstraints = false
        _proteinsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: .zero)

        self.alignment = .center
        self.axis = .horizontal
        self.spacing = 4
        
        self.set(energy: 0, carbohydrates: 0, fats: 0, proteins: 0)

        [_enegryLabel, _oval1, _carbohydratesLabel, _oval2, _fatsLabel, _oval3, _proteinsLabel, filler].forEach({
            self.addArrangedSubview($0)
        })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func set(energy: Double, carbohydrates: Double, fats: Double, proteins: Double) {
        
        _energy = energy
        _carbohydrates = carbohydrates
        _fats = fats
        _proteins = proteins
        
        let energyUnit = _energyUnit ?? ""
        let weightUnit = _weightUnit ?? ""
        _enegryLabel.setRecipySubheader("\(Int(_energy)) \(energyUnit)")
        _carbohydratesLabel.setRecipySubheader("\(Int(_carbohydrates))\(weightUnit) Carbs")
        _fatsLabel.setRecipySubheader("\(Int(_fats))\(weightUnit) Fat")
        _proteinsLabel.setRecipySubheader("\(Int(_proteins))\(weightUnit) Proteins")
        
        _enegryLabel.addSizeConstraints()
        _oval1.addSizeConstraints()
        _carbohydratesLabel.addSizeConstraints()
        _oval2.addSizeConstraints()
        _fatsLabel.addSizeConstraints()
        _oval3.addSizeConstraints()
        _proteinsLabel.addSizeConstraints()
//        print("constraints.count \(_proteinsLabel.constraints.count)")
    }
}
