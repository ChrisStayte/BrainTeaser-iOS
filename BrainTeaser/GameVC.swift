//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Chris Stayte on 3/20/16.
//  Copyright © 2016 Chris Stayte. All rights reserved.
//

import UIKit
import pop

class GameVC: UIInputViewController {

    
    @IBOutlet weak var yesBtn: BouncyButton!
    @IBOutlet weak var noBtn: BouncyButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    var currentCard: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
    }
    
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer()
        } else {
            titleLbl.text = "Does this card match the previous?"
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        checkAnswer()
        showNextCard()
    }
    
    func checkAnswer() {
        
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
            
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("Yes", forState: .Normal)
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation!,finished:Bool) -> Void in
            })
            
        }
    }
    
    func createCardFromNib() -> Card! {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }

}
