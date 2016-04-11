//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Stefan Blos on 21.03.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
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
        
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), forControlEvents: .TouchDragInside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), forControlEvents: .TouchDragExit)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.tintColor = fontColor
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.velocity = NSValue(CGSize: CGSizeMake(5.0, 5.0))
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 20
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleDefaultAnimation")
    }
    
}