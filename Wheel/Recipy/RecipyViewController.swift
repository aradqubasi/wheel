//
//  RecipyViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RecipyViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWRecipyAssembler!
    
    var selection: [SWIngredient]!
    
    // MARK: - Private Properties
    
    private var _selectionViews: [SWRecipyIngridientView]!
    
    private var _segues: SWSegueRepository!
    
    private var _selectionContainer: UIView!
    
    private var _recipyHeaderContainer: UIView!
    
    private var _name: String!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = assembler.resolve().getName(for: selection)
        
        _segues = assembler.resolve()
        
        _selectionContainer = UIView()
        view.addSubview(_selectionContainer)

        let box = CGSize(width: 88, height: 88)
        let innerSpacing = CGPoint(x: 8, y: 24)
        let outerSpacing = CGPoint(x: 16, y: 24)
        let perLine = Int((view.bounds.width + innerSpacing.x - outerSpacing.x * 2) / (box.width + innerSpacing.x))
        var line: Int = 0
        var position: Int = 0
        
//        print("per line - \(perLine)")
//        print("width - \(view.bounds.width)")
        selection?.forEach({
            if position >= perLine && position != 0 {
                position = 0
                line = line + 1
            }
            print($0.name)
            let left = /*outerSpacing.x + */CGFloat(position) * (box.width + innerSpacing.x)
            let top = /*outerSpacing.y + */CGFloat(line) * (box.height + innerSpacing.y)
            let next = SWRecipyIngridientView(frame: CGRect(origin: CGPoint(x: left, y: top), size: box), for: $0)
            next.alignSubviews()
//            view.addSubview(next)
            _selectionContainer.addSubview(next)
            position = position + 1
        })
        
        let width = CGFloat(perLine) * box.width + CGFloat(perLine - 1) * innerSpacing.x
        let height = CGFloat(line) * box.height + CGFloat(line - 1) * innerSpacing.y
        _selectionContainer.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))

//        _selectionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //print("self.topLayoutGuide.length \(self.topLayoutGuide.length)")
//        _selectionContainer.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
//        _selectionContainer.addSizeConstraints()
//        _selectionContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.aquaHaze
        
        _recipyHeaderContainer = UIView()
        
        let recipyHeader = UILabel.getRecipyHeader(_name)
        
        _recipyHeaderContainer.addSubview(recipyHeader)
        
//        _recipyHeaderContainer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: ))

        navigationItem.titleView = UILabel.getRecipyTitle(_name)
        
        let back = UIBarButtonItem.back
        navigationItem.leftBarButtonItem = back
        back.action = #selector(onBackButtonClick(_:))
        back.target = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {

        let outerSpacing = CGPoint(x: 16, y: 24)
        _selectionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _selectionContainer.translatesAutoresizingMaskIntoConstraints = false
        _selectionContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: topLayoutGuide.length + outerSpacing.y).isActive = true
        _selectionContainer.addSizeConstraints()
                
        print("self.topLayoutGuide.length \(self.topLayoutGuide.length)")
        super.viewWillLayoutSubviews()
        print("self.topLayoutGuide.length \(self.topLayoutGuide.length)")
    }
    
    // MARK: - Actions
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        
        performSegue(withIdentifier: _segues.getRecipyToWheels().identifier, sender: self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
