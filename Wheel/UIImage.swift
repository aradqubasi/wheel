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
    
    // MARK: - Protein Images
    
    static var beans: UIImage {
        get {
            return UIImage(named: "_beans")!
        }
    }
    
    static var Beans: UIImage {
        get {
            return UIImage(named: "beans")!
        }
    }
    
    static var boiledegg: UIImage {
        get {
            return UIImage(named: "_boiledegg")!
        }
    }
    
    static var Boiledegg: UIImage {
        get {
            return UIImage(named: "boiledegg")!
        }
    }
    
    static var chickpeas: UIImage {
        get {
            return UIImage(named: "_chickpeas")!
        }
    }
    
    static var Chickpeas: UIImage {
        get {
            return UIImage(named: "chickpeas")!
        }
    }
    
    static var fish: UIImage {
        get {
            return UIImage(named: "_fish")!
        }
    }
    
    static var Fish: UIImage {
        get {
            return UIImage(named: "fish")!
        }
    }
    
    static var friedegg: UIImage {
        get {
            return UIImage(named: "_friedegg")!
        }
    }
    
    static var Friedegg: UIImage {
        get {
            return UIImage(named: "friedegg")!
        }
    }
 
    static var lentils: UIImage {
        get {
            return UIImage(named: "_lentils")!
        }
    }
    
    static var Lentils: UIImage {
        get {
            return UIImage(named: "lentils")!
        }
    }
    
    static var mushrooms: UIImage {
        get {
            return UIImage(named: "_mushrooms")!
        }
    }
    
    static var Mushrooms: UIImage {
        get {
            return UIImage(named: "mushrooms")!
        }
    }
    
    static var peas: UIImage {
        get {
            return UIImage(named: "_peas")!
        }
    }
    
    static var Peas: UIImage {
        get {
            return UIImage(named: "peas")!
        }
    }
    
    static var shrimp: UIImage {
        get {
            return UIImage(named: "_shrimp")!
        }
    }
    
    static var Shrimp: UIImage {
        get {
            return UIImage(named: "shrimp")!
        }
    }
    
    // MARK: - Fats
    
    static var avocado: UIImage {
        get {
            return UIImage(named: "_avocado")!
        }
    }
    
    static var Avocado: UIImage {
        get {
            return UIImage(named: "avocado")!
        }
    }
    
    static var brazilnut: UIImage {
        get {
            return UIImage(named: "_brazilnut")!
        }
    }
    
    static var Brazilnut: UIImage {
        get {
            return UIImage(named: "brazilnut")!
        }
    }
    
    static var cashewnut: UIImage {
        get {
            return UIImage(named: "_cashewnut")!
        }
    }
    
    static var Cashewnut: UIImage {
        get {
            return UIImage(named: "cashewnut")!
        }
    }
    
    static var coconut: UIImage {
        get {
            return UIImage(named: "_coconut")!
        }
    }
    
    static var Coconut: UIImage {
        get {
            return UIImage(named: "coconut")!
        }
    }
    
    static var hazelnut: UIImage {
        get {
            return UIImage(named: "_hazelnut")!
        }
    }
    
    static var Hazelnut: UIImage {
        get {
            return UIImage(named: "hazelnut")!
        }
    }
    
    static var peanut: UIImage {
        get {
            return UIImage(named: "_peanut")!
        }
    }
    
    static var Peanut: UIImage {
        get {
            return UIImage(named: "peanut")!
        }
    }
    
    static var seeds: UIImage {
        get {
            return UIImage(named: "_seeds")!
        }
    }
    
    static var Seeds: UIImage {
        get {
            return UIImage(named: "seeds")!
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
    
    // MARK: - Extended Methods
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
