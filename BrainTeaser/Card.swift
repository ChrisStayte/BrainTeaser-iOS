//
//  Card.swift
//  BrainTeaser
//
//  Created by Chris Stayte on 3/20/16.
//  Copyright © 2016 Chris Stayte. All rights reserved.
//

import UIKit

class Card: UIView {

    let flags = ["flag1", "flag2", "flag3"]
    var currentFlag: String!
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var resultImage: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        selectFlag()
    }
    
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.setNeedsLayout()
        
    }
    
    func selectFlag() {
        let randomNumber = Int(arc4random_uniform(3))
        currentFlag = flags[randomNumber]
        flagImage.tag = randomNumber
        flagImage.image = UIImage(named: currentFlag)
        
    }
    
    func showResult(isCard: Bool) {
        if isCard{
            self.resultImage.image = UIImage(named: "correct")
        } else {
            self.resultImage.image = UIImage(named: "incorrect")
        }
        self.resultImage.hidden = false
    }
    
    

}
