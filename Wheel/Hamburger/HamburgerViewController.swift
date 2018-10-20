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
    
    private let width: CGFloat = 300
    
    private let menu: UIView = UIView()
    
    private var background: UIView!
    
    private var swiper: SWDismissHamburgerGestureRecognizer!
    
    private var transitioning: UIPercentDrivenInteractiveTransition!
    
    private var walkthrough: UIButton!
    
    private var diet: UIButton!
    
    private var history: UIButton!
    
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
            self.swiper = SWDismissHamburgerGestureRecognizer()
            self.view.addGestureRecognizer(self.swiper)
            self.swiper.addTarget(self, action: #selector(onSwipe(sender:)))
            self.transitioning = UIPercentDrivenInteractiveTransition()
        }
        
        do {
            diet = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: menu.bounds.width, height: 80)))
            diet.setAttributedTitle(.hamburgerDietLabel, for: .normal)
            diet.contentHorizontalAlignment = .left
            diet.contentEdgeInsets = UIEdgeInsetsMake(0, 72, 0, 0)
            diet.addTarget(self, action: #selector(onDietClick), for: .touchUpInside)
            self.menu.addSubview(diet)
            do {
                let icon = UIImageView(image: #imageLiteral(resourceName: "Hamburger/diet preferences"))
                diet.addSubview(icon)
                icon.center = CGPoint(x: 36, y: 40)
            }
            do {
                let goto = UIImageView(image: #imageLiteral(resourceName: "Hamburger/goto"))
                diet.addSubview(goto)
                goto.center = CGPoint(x: diet.frame.width - 35, y: 40)
            }
            diet.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 97)
        }
        
        do {
            history = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: menu.bounds.width, height: 80)))
            history.setAttributedTitle(.hamburgerHistoryLabel, for: .normal)
            history.contentHorizontalAlignment = .left
            history.contentEdgeInsets = UIEdgeInsetsMake(0, 72, 0, 0)
            history.addTarget(self, action: #selector(onHistoryClick), for: .touchUpInside)
            self.menu.addSubview(history)
            do {
                let icon = UIImageView(image: #imageLiteral(resourceName: "Hamburger/history"))
                history.addSubview(icon)
                icon.center = CGPoint(x: 36, y: 40)
            }
            do {
                let goto = UIImageView(image: #imageLiteral(resourceName: "Hamburger/goto"))
                history.addSubview(goto)
                goto.center = CGPoint(x: history.frame.width - 35, y: 40)
            }
            history.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 97 + 80)
        }
        
        do {
            walkthrough = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: menu.bounds.width, height: 80)))
            walkthrough.setAttributedTitle(.hamburgerWalkthroughLabel, for: .normal)
            walkthrough.contentHorizontalAlignment = .left
            walkthrough.contentEdgeInsets = UIEdgeInsetsMake(0, 72, 0, 0)
            walkthrough.addTarget(self, action: #selector(onWalkthroughClick), for: .touchUpInside)
            self.menu.addSubview(walkthrough)
            do {
                let icon = UIImageView(image: #imageLiteral(resourceName: "Hamburger/walkthrough"))
                walkthrough.addSubview(icon)
                icon.center = CGPoint(x: 36, y: 40)
            }
            do {
                let goto = UIImageView(image: #imageLiteral(resourceName: "Hamburger/goto"))
                walkthrough.addSubview(goto)
                goto.center = CGPoint(x: walkthrough.frame.width - 35, y: 40)
            }
            walkthrough.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 97 + 80 + 80)
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
    
    @IBAction func onHistoryClick() {
        print("onHistoryClick")
    }
    
    @IBAction func onDietClick() {
        print("onDietClick")
    }
    
    @IBAction func onWalkthroughClick() {
        print("onWalkthroughClick")
    }
    
    @IBAction func onSwipe(sender: SWDismissHamburgerGestureRecognizer) {
        if sender.state == .began {
            print("began")
            perform(segue: segues.getHamburgerToWheelsWithSwipe())
        }
        else if sender.state == .changed {
            print("changed \(sender.Progress)")
            self.transitioning.update(sender.Progress)
        }
        else if sender.state == .cancelled {
            print("cancelled")
            self.transitioning.cancel()
        }
        else if sender.state == .ended {
            print("ended")
            self.transitioning.finish()
        }
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

extension HamburgerViewController: SWDismissableViewController {
    
    func interactionControllerForDismissal() -> UIViewControllerInteractiveTransitioning? {
        return self.transitioning
    }

}

