//
//  UIImage.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/10/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    // MARK: - Veggies Images
    
    static var asparagus: UIImage {
        get {
            return UIImage(named: "_asparagus")!
        }
    }
 
    static var Asparagus: UIImage {
        get {
            return UIImage(named: "asparagus")!
        }
    }
    
    static var aubergine: UIImage {
        get {
            return UIImage(named: "_aubergine")!
        }
    }

    static var Aubergine: UIImage {
        get {
            return UIImage(named: "aubergine")!
        }
    }
    
    static var broccoli: UIImage {
        get {
            return UIImage(named: "_broccoli")!
        }
    }
 
    static var Broccoli: UIImage {
        get {
            return UIImage(named: "broccoli")!
        }
    }
    
    static var carrot: UIImage {
        get {
            return UIImage(named: "_carrot")!
        }
    }

    static var Carrot: UIImage {
        get {
            return UIImage(named: "carrot")!
        }
    }
    
    static var cauliflower: UIImage {
        get {
            return UIImage(named: "_cauliflower")!
        }
    }
  
    static var Cauliflower: UIImage {
        get {
            return UIImage(named: "cauliflower")!
        }
    }
    
     static var corn: UIImage {
        get {
            return UIImage(named: "_corn")!
        }
    }

    static var Corn: UIImage {
        get {
            return UIImage(named: "corn")!
        }
    }
    
    static var pepper: UIImage {
        get {
            return UIImage(named: "_pepper")!
        }
    }

    static var Pepper: UIImage {
        get {
            return UIImage(named: "pepper")!
        }
    }
    
    static var radish: UIImage {
        get {
            return UIImage(named: "_radish")!
        }
    }

    static var Radish: UIImage {
        get {
            return UIImage(named: "radish")!
        }
    }
    
    static var tomato: UIImage {
        get {
            return UIImage(named: "_tomato")!
        }
    }
    
    static var Tomato: UIImage {
        get {
            return UIImage(named: "tomato")!
        }
    }
    
    // MARK: - Custom Initializer
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
