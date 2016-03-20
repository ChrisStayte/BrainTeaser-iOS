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
    @IBOutlet weak var timerLbl: UILabel!
    
    var currentCard: Card!
    var previousCard: Card!
    
    var totalCards: Int = 0
    var correctCards: Int = 0
    var incorrectCards: Int = 0
    
    var timerCount = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
    }
    
    func countDown() {
        if timerCount >= 0 {
            timerLbl.text = String(timerCount--)
        } else {
            performSegueWithIdentifier("Results", sender: nil)
        }
    }
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer("Yes")
        } else {
            titleLbl.text = "Does this card match the previous?"
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        checkAnswer("No")
        showNextCard()
    }
    
    func checkAnswer(answer: String) {
        totalCards++
        if answer == "Yes" {
            if currentCard.flagImage.tag == previousCard.flagImage.tag {
                currentCard.showResult(true)
                correctCards++
            } else {
                currentCard.showResult(false)
                incorrectCards++
            }
        }
        if answer == "No"  {
            if currentCard.flagImage.tag == previousCard.flagImage.tag  {
                currentCard.showResult(false)
                incorrectCards++
            } else {
                currentCard.showResult(true)
                correctCards++
            }
        }
    }
    
    func showNextCard() {
        self.previousCard = self.currentCard
        if let current = self.currentCard {
            let cardToRemove = current
            self.currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
            
        if let next = self.createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            self.currentCard = next
            
            if self.noBtn.hidden {
                self.noBtn.hidden = false
                self.yesBtn.setTitle("YES", forState: .Normal)
                self.timerLbl.hidden = false
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation!,finished:Bool) -> Void in})
            }
    }
    
    func createCardFromNib() -> Card! {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Results" {
            if let view = segue.destinationViewController as? ResultsVC {
                view._total = totalCards
                view._correct = correctCards
                view._incorrect = incorrectCards
            }
        }
    }

}
