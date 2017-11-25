//
//  PinView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class PinView: UIButton {
    
    // MARK: - Subviews
    
    // MARK: - Publish Properties
    
    var delegate: PVDelegate?
    
    var images: [WState: [SVState: UIImage]] = [:]
    
    var name: String = ""
    
    // MARK: - Overriden Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouchesBegan(self, touches, with: event)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouchesMoved(self, touches, with: event)
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouchesEnded(self, touches, with: event)
        super.touchesEnded(touches, with: event)
    }
    
    // MARK: - Helpers
    
    func icon(default image: UIImage) -> PinView {
        for wState in WState.all {
            let svState: [SVState: UIImage] = [.focused: image, .visible: image, .invisible: image.alpha(0)]
            images[wState] = svState
        }
        return self
    }
    
    func icon(_ image: UIImage, for state: WState) -> PinView {
        images[state] = [.focused: image, .visible: image.alpha(0.5), .invisible: image.alpha(0)]
        return self
    }
    
    func name(_ name: String) -> PinView {
        self.name = name
        return self
    }
    
    static var create: PinView {
        get {
            return PinView()
        }
    }
}
