//
//  OnboardingViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var skip: UIButton!
    
    @IBOutlet weak var pager: UIView!
    
    var obey: SWSliderView!
//    var greens: UITextView!
//    var proteins: UITextView!
//    var veggies: UITextView!
//    var fats: UITextView!
//    var ehancers: UITextView!
    
    // MARK: - Private Properties
    
    private var pagerController: SWPagerController!
    
    // MARK: - Initalization

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup gradient on background
        do {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.tanhide.cgColor, UIColor.radicalred.cgColor]
            gradient.frame = view.bounds
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            gradient.locations = [-0.23, 0.15, 0.82]
            view.layer.insertSublayer(gradient, at: 0)
            //-176 109 600 of 736
        }
        
        //setup pager
        do {
            pagerController = SWPagerController(pager)
        }
        
        //setup sliders
        do {
            obey = SWObeySlideView(frame: view.bounds)
            view.addSubview(obey)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
