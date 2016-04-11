//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Stefan Blos on 22.03.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]
    
    init(constraints: [NSLayoutConstraint]) {
        for const in constraints {
            originalConstants.append(const.constant)
            const.constant = AnimationEngine.offScreenRightPosition.x
        }
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springSpeed = 10.0
                moveAnim.springBounciness = 20.0
                
                if index > 0 {
                    moveAnim.dynamicsFriction += 2 + CGFloat(index)
                }
                
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                index = index + 1
            } while index < self.constraints.count
            
        }
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation!, Bool) -> Void)) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springSpeed = 1
        moveAnim.springBounciness = 5
        moveAnim.completionBlock = completion
        view.pop_addAnimation(moveAnim, forKey: "moveToPosition")
    }
}
