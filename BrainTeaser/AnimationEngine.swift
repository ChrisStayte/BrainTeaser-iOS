//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Chris Stayte on 3/19/16.
//  Copyright © 2016 Chris Stayte. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    var orginalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    init(constraints: [NSLayoutConstraint]) {
        for con in constraints {
            orginalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int) {
        
        //let d:Int64 = delay == nil ? Int64(Double(ANIM_DELAY) * Double(NSEC_PER_SEC)) : delay!
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) { // To Delay it using Swift Code
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.orginalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                if (index > 0) {
                    moveAnim.dynamicsFriction += 10 + CGFloat(index) // This puts friction on all of them 
                }
            
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index++
                
            } while (index < self.constraints.count)
        }
    }
}
