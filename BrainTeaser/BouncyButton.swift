//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Chris Stayte on 3/19/16.
//  Copyright © 2016 Chris Stayte. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class BouncyButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.whiteColor() {
        didSet {
            setupView()
        }
    }
    
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.tintColor = fontColor
        
        self.addTarget(self, action: "scaleToSmall", forControlEvents: .TouchDown)
        self.addTarget(self, action: "scaleToSmall", forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: "scaleAnimation", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "scaleToDefault", forControlEvents: .TouchDragExit)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation") // what I want
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 18
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation") // what I want
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleDefaultAnimation") // what I want
        
    }

}
