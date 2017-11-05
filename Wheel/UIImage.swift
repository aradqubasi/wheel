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
    
    var asparagus: UIImage {
        get {
            return UIImage(named: "_asparagus")!
        }
    }
 
    var Asparagus: UIImage {
        get {
            return UIImage(named: "asparagus")!
        }
    }
    
    var aubergine: UIImage {
        get {
            return UIImage(named: "_aubergine")!
        }
    }

    var Aubergine: UIImage {
        get {
            return UIImage(named: "aubergine")!
        }
    }
    
    var broccoli: UIImage {
        get {
            return UIImage(named: "_broccoli")!
        }
    }
 
    var Broccoli: UIImage {
        get {
            return UIImage(named: "broccoli")!
        }
    }
    
    var carrot: UIImage {
        get {
            return UIImage(named: "_carrot")!
        }
    }

    var Carrot: UIImage {
        get {
            return UIImage(named: "carrot")!
        }
    }
    
    var cauliflower: UIImage {
        get {
            return UIImage(named: "_cauliflower")!
        }
    }
  
    var Cauliflower: UIImage {
        get {
            return UIImage(named: "cauliflower")!
        }
    }
    
    var corn: UIImage {
        get {
            return UIImage(named: "_corn")!
        }
    }

    var Corn: UIImage {
        get {
            return UIImage(named: "corn")!
        }
    }
    
    var pepper: UIImage {
        get {
            return UIImage(named: "pepper")!
        }
    }

    var Pepper: UIImage {
        get {
            return UIImage(named: "Pepper")!
        }
    }
    
    var radish: UIImage {
        get {
            return UIImage(named: "radish")!
        }
    }

    var Radish: UIImage {
        get {
            return UIImage(named: "Radish")!
        }
    }
    
    var tomato: UIImage {
        get {
            return UIImage(named: "tomato")!
        }
    }
    
    var Tomato: UIImage {
        get {
            return UIImage(named: "Tomato")!
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
