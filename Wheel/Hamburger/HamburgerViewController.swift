//
//  HamburgerViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 16/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class HamburgerViewController: SWViewController {
    
    //MARK: - Public Properties
    
    var assembler: SWHamburgerAssembler!
    
    //MARK: - Private Properties
    
    let width: CGFloat = 300
    
    let menu: UIView = UIView()
    
    var background: UIView!
    
    var swiper: UISwipeGestureRecognizer!
    
    //MARK: - Bootstraping

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        segues = assembler.resolve()
        
        do {
            self.background = assembler.resolve()
            self.view.addSubview(self.background)
        }
        
        do {
            self.view.addSubview(self.menu)
            self.menu.frame = CGRect(origin: .zero, size: CGSize(width: self.width, height: self.view.bounds.height))
            self.menu.backgroundColor = .white
            self.menu.layer.shadowRadius = 4
            self.menu.layer.shadowOpacity = 0.4
            self.menu.layer.shadowColor = UIColor.black.cgColor
            self.menu.layer.shadowPath = UIBezierPath(rect: self.menu.bounds).cgPath
            self.menu.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
        
        do {
            self.swiper = UISwipeGestureRecognizer()
            self.swiper.addTarget(self, action: #selector(onSwipeLeft))
            self.swiper.direction = .left
            self.view.addGestureRecognizer(swiper)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action Methods
    
    @IBAction func onSwipeLeft() {
        print("onSwipeLeft")
        perform(segue: segues.getHamburgerToWheelsWithSwipe())
    }

    //MARK: - Animation Methods
    
    func hide() -> Void {
        self.menu.transform = CGAffineTransform.identity.translatedBy(x: -self.menu.frame.width, y: 0)
    }
    
    func popup() -> Void {
        self.menu.transform = CGAffineTransform.identity
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
