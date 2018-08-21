//
//  WalkthroughViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class WalkthroughViewController: SWViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWWalkthroughAssembler!
    
    // MARK: - Private Properties
    
    private var tipController: SWTipController!
    
    private var areas: SWAreasOfInterest!
    
    // MARK: - Subviews
    
    private var rollbutton: UIView!
    
    private var selectionWheel: UIView!
    
    private var cookbutton: UIView!
    
    private var filterbutton: UIView!
    
    private var enhancerbutton: UIView!
    
    private var pinview: UIView!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        let background: UIView = assembler.resolve()
        view.addSubview(background)
        
        let shroud = UIView(frame: view.bounds)
        shroud.backgroundColor = UIColor.limedSpruceTransparent
        view.addSubview(shroud)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        
        self.tipController = SWTipController()
        
        self.areas = assembler.resolve()
        
        //random salad
        do {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                do {
                    self.rollbutton = UIView()
                    self.initWalkthrough(as: self.rollbutton, at: self.areas.rollButton, in: self.view, with: background, margin: 60)
                    self.animateWalkthrough(self.rollbutton, in: self.view, with: self.tipController, text: "Press this button to generate salad!", at: .midright)
                }
            })
            
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { _ in
                do {
                    self.fadeWalkthrough(self.rollbutton, in: self.view, with: self.tipController)
                }
            })
        }

        //selection wheel
        do {
            Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false, block: { _ in
                do {
                    self.selectionWheel = UIView()
                    self.initWalkthrough(as: self.selectionWheel, at: self.areas.selectionWheel, in: self.view, with: background, margin: 60)
                    self.animateWalkthrough(self.selectionWheel, in: self.view, with: self.tipController, text: "This is plate with ingredients, pan left/right to rotate it", at: .midbottom)
                }
            })
            
            Timer.scheduledTimer(withTimeInterval: 7.5, repeats: false, block: { _ in
                do {
                    self.fadeWalkthrough(self.selectionWheel, in: self.view, with: self.tipController)
                }
            })
        }

        //cook button
        do {
            Timer.scheduledTimer(withTimeInterval: 8, repeats: false, block: { _ in
                do {
                    self.cookbutton = UIView()
                    self.initWalkthrough(as: self.cookbutton, at: self.areas.cookButton, in: self.view, with: background, margin: 60)
                    self.animateWalkthrough(self.cookbutton, in: self.view, with: self.tipController, text: "Once all ingredeitns in place, tap to navigate to recipy", at: .rightbottom)
                }
            })
            
            Timer.scheduledTimer(withTimeInterval: 11, repeats: false, block: { _ in
                do {
                    self.fadeWalkthrough(self.cookbutton, in: self.view, with: self.tipController)
                }
            })
        }

        //filter button
        do {
            Timer.scheduledTimer(withTimeInterval: 11.5, repeats: false, block: { _ in
                do {
                    self.filterbutton = UIView()
                    self.initWalkthrough(as: self.filterbutton, at: self.areas.filtersButton, in: self.view, with: background, margin: 60)
                    self.animateWalkthrough(self.filterbutton, in: self.view, with: self.tipController, text: "Customize your food preferences here", at: .midright)
                }
            })
            
            Timer.scheduledTimer(withTimeInterval: 14.5, repeats: false, block: { _ in
                do {
                    self.fadeWalkthrough(self.filterbutton, in: self.view, with: self.tipController)
                }
            })
        }
        
        //wheel pin
        do {
            Timer.scheduledTimer(withTimeInterval: 15, repeats: false, block: { _ in
                do {
                    self.pinview = UIView()
                    self.initWalkthrough(as: self.pinview, at: self.areas.wheelIngredient, in: self.view, with: background, margin: 60)
                    self.animateWalkthrough(self.pinview, in: self.view, with: self.tipController, text: "Click to select ingredient, pan to rotate wheel", at: .midtop)
                }
            })
            
            Timer.scheduledTimer(withTimeInterval: 18, repeats: false, block: { _ in
                do {
                    self.fadeWalkthrough(self.pinview, in: self.view, with: self.tipController)
                }
            })
        }
        
        // enhancer
        do {
            Timer.scheduledTimer(withTimeInterval: 18.5, repeats: false, block: { _ in
                do {
                    self.enhancerbutton = UIView()
                    self.initWalkthrough(as: self.enhancerbutton, at: self.areas.enhancer, in: self.view, with: background, margin: 60)
                    self.animateWalkthrough(self.enhancerbutton, in: self.view, with: self.tipController, text: "Variety of flavour enhancers are located here, click to see them", at: .midtop)
                }
            })
            
            Timer.scheduledTimer(withTimeInterval: 21.5, repeats: false, block: { _ in
                do {
                    self.fadeWalkthrough(self.enhancerbutton, in: self.view, with: self.tipController)
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Animation Methods
    
    private func initWalkthrough(as circle: UIView, at area: SWAreaOfInterest, in scene: UIView, with background: UIView, margin: CGFloat) {
        let side = max(area.size.width, area.size.height) + margin
        circle.frame = CGRect(origin: .zero, size: CGSize(side: side))
        scene.addSubview(circle)
        circle.center = area.center
        circle.layer.cornerRadius = side * 0.5
        circle.clipsToBounds = true
        let copyground = background.snapshotView(afterScreenUpdates: false)!
        circle.addSubview(copyground)
        copyground.frame.origin = scene.convert(.zero, to: circle)
        circle.alpha = 0
//        circle.layer.borderColor = UIColor.black.cgColor
//        circle.layer.borderWidth = 2
    }
    
    private func animateWalkthrough(_ circle: UIView, in scene: UIView, with tip: SWTipController, text: String, at orientation: SWTipOrientation) {
        
        var anchor: CGPoint = .zero
        switch orientation {
        case .midbottom, .rightbottom:
            anchor = CGPoint(x: circle.center.x, y: circle.frame.origin.y)
        case .midright:
            anchor = CGPoint(x: circle.frame.origin.x, y: circle.center.y)
        case .midtop:
            anchor = CGPoint(x: circle.center.x, y: circle.frame.origin.y + circle.frame.height)
//        default:
//            fatalError("No anchor for \(orientation)")
        }

        tip.orientation = orientation
        tip.show(tip: text, at: anchor, in: view)
        tip.shrink()
        
        circle.alpha = 1
        let center = circle.center
        let side = circle.frame.size.width
        let subViewOrigin = circle.subviews.first!.frame.origin
        
        do {
            circle.frame.size = CGSize(side: side * 0.1)
            circle.layer.cornerRadius = side * 0.5 * 0.1
            circle.center = center
            circle.subviews.first!.frame.origin = scene.convert(.zero, to: circle)
        }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
            do {
                circle.frame.size = CGSize(side: side)
                circle.layer.cornerRadius = side * 0.5
                circle.center = center
                circle.subviews.first!.frame.origin = subViewOrigin
            }
            do {
                tip.grow()
            }
        }, completion: {
            (success:Bool) in
        })
    }
    
    private func fadeWalkthrough(_ circle: UIView, in scene: UIView, with tip: SWTipController) {

        circle.alpha = 1
        let center = circle.center
        let side = circle.frame.size.width
        let subViewOrigin = circle.subviews.first!.frame.origin
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
            do {
                circle.frame.size = CGSize(side: side * 0.1)
                circle.layer.cornerRadius = side * 0.5 * 0.1
                circle.center = center
                circle.alpha = 0
                circle.subviews.first!.frame.origin = scene.convert(.zero, to: circle)
            }
            do {
                tip.fade()
            }
        }, completion: {
            (success:Bool) in
            circle.frame.size = CGSize(side: side)
            circle.layer.cornerRadius = side * 0.5
            circle.center = center
            circle.subviews.first!.frame.origin = subViewOrigin
        })
    }
    
//    private func showRollbuttonWalk(_ circle: UIView, in scene: UIView, with tip: SWTipController) {
//        let midleft = CGPoint(x: circle.frame.origin.x, y: circle.center.y)
//        tip.orientation = .midright
//        tip.show(tip: "Press this button to generate salad!", at: midleft, in: view)
//        tip.shrink()
//
//        circle.alpha = 1
//        let center = circle.center
//        let side = circle.frame.size.width
//
//        do {
//            circle.frame.size = CGSize(side: side * 0.1)
//            circle.layer.cornerRadius = side * 0.5 * 0.1
//            circle.center = center
//        }
//
//        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
//            do {
//                circle.frame.size = CGSize(side: side)
//                circle.layer.cornerRadius = side * 0.5
//                circle.center = center
//            }
//            do {
//                tip.grow()
//            }
//        }, completion: {
//            (success:Bool) in
//        })
//    }
//
//    private func showSelectionWheel(_ circle: UIView, in scene: UIView, with tip: SWTipController) {
//        let midtop = CGPoint(x: circle.center.x, y: circle.frame.origin.y)
//        tip.orientation = .midbottom
//        tip.show(tip: "This is plate with ingredients, pan left/right to rotate it", at: midtop, in: view)
//        tip.shrink()
//
//        circle.alpha = 1
//        let center = circle.center
//        let side = circle.frame.size.width
//
//        do {
//            circle.frame.size = CGSize(side: side * 0.1)
//            circle.layer.cornerRadius = side * 0.5 * 0.1
//            circle.center = center
//        }
//
//        UIView.animate(withDuration: 0.225, delay: 0.225, options: [.curveEaseOut], animations: {
//            do {
//                circle.frame.size = CGSize(side: side)
//                circle.layer.cornerRadius = side * 0.5
//                circle.center = center
//            }
//            do {
//                tip.grow()
//            }
//        }, completion: {
//            (success:Bool) in
//        })
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
