//
//  ResultsVC.swift
//  BrainTeaser
//
//  Created by Chris Stayte on 3/20/16.
//  Copyright © 2016 Chris Stayte. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {

    @IBOutlet weak var totalCardsLbl: UILabel!
    @IBOutlet weak var correctCardsLbl: UILabel!
    @IBOutlet weak var incorrectCardsLbl: UILabel!
    
    var _total: Int = 0
    var _correct: Int = 0
    var _incorrect: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalCardsLbl.text  = "\(_total)"
        correctCardsLbl.text = "\(_correct)"
        incorrectCardsLbl.text = "\(_incorrect)"
    }
    
    @IBAction func restartGame(sender: AnyObject) {
    }


}
