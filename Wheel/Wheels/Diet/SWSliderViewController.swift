//
//  SWSliderViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWSliderViewController: UIViewController {
    
    var size: CGSize!
    
    var slider: UIPanGestureRecognizer!
    
    var progress: Double = 0
    
    private var timer: Timer!
    
    private var column: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progress = 0
        
        do {
            self.slider = UIPanGestureRecognizer()
        }
        
        do {
            self.column = UIView()
            self.view.addSubview(self.column)
        }
        

        
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    func alignSubviews() {
        do {
            
        }
        
        do {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
                _ in
                
            })
        }
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
