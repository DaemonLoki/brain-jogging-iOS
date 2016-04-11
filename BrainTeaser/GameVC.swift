//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Stefan Blos on 23.03.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {

    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var containerCardView: UIView!
    
    let TIME_LIMIT = 30
    
    var currentCard: Card?
    var previousCard: Card?
    var scoreBoard: ScoreBoard?
    var timer = NSTimer()
    var counter: Int!
    var correctAnswers = 0
    var wrongAnswers = 0
    var gameRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareForGame()
    }
    
    @IBAction func yesPressed(sender: CustomButton) {
        
        if sender.titleLabel?.text == "YES" {
            if gameRunning {
                checkAnswer(true)
                showNextCard()
            }
        } else if sender.titleLabel?.text == "REPLAY" {
            prepareForGame()
        } else {
            startGame()
            previousCard = currentCard
            showNextCard()
        }
    }
    
    @IBAction func noPressed(sender: CustomButton) {
        if gameRunning {
            checkAnswer(false)
            showNextCard()
        }
    }

    func checkAnswer(answer: Bool) {
        if let previous = previousCard {
            if  let current = currentCard {
                
                let match = (previous.currentShape == current.currentShape)
                
                if match == answer {
                    correctAnswers = correctAnswers + 1
                    current.setResultImage(true)
                } else {
                    wrongAnswers = wrongAnswers + 1
                    current.setResultImage(false)
                }
            }
            
            
            
        } else {
            print("ERROR: previousCard not found")
        }
        
        previousCard = currentCard
    }
    
    func prepareForGame() {
        if let board = scoreBoard {
            board.removeFromSuperview()
        }
        
        correctAnswers = 0
        wrongAnswers = 0
        titleLbl.text = "Remember this image"
        yesBtn.setTitle("START", forState: .Normal)
        timerLbl.text = convertToTimeString(TIME_LIMIT)
        
        currentCard = createCardFromNib()
        currentCard!.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard!)
    }
    
    func startGame() {
        titleLbl.text = "Does this card match the previous?"
        gameRunning = true
        timerLbl.hidden = false
        counter = TIME_LIMIT
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func endGame() {
        gameRunning = false
        timerLbl.hidden = true
        titleLbl.text = "Time is up!"
        noBtn.hidden = true
        yesBtn.userInteractionEnabled = false
        yesBtn.setTitle("REPLAY", forState: .Normal)
        yesBtn.alpha = 0.3
        
        removeCurrentCard()
        
        bringOnScoreBoard()
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(3) * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.yesBtn.alpha = 1.0
            self.yesBtn.userInteractionEnabled = true
        }
    }
    
    func showNextCard() {
        removeCurrentCard()
        
        bringOnNewCard()
    }
    
    func removeCurrentCard() {
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished:Bool) in
                cardToRemove.removeFromSuperview()
            })
        }
    }
    
    func bringOnNewCard() {
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if (noBtn.hidden) {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
            }
            
            AnimationEngine.animateToPosition(currentCard!, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) in
                // anything to add?
            })
            
        }
    }
    
    func bringOnScoreBoard() {
        if let board = createScoreBoardFromNib() {
            board.setResult(correctAnswers, wrong: wrongAnswers)
            board.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(board)
            self.scoreBoard = board
            
            AnimationEngine.animateToPosition(board, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) in
                //
            })
        }
    }
    
    func createCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    func createScoreBoardFromNib() -> ScoreBoard? {
        return NSBundle.mainBundle().loadNibNamed("ScoreBoard", owner: self, options: nil)[0] as? ScoreBoard
    }
    
    func updateTimerLabel() {
        counter = counter - 1
        timerLbl.text = convertToTimeString(counter)
        
        if counter == 0 {
            timer.invalidate()
            endGame()
        }
    }
    
    func convertToTimeString(count: Int) -> String {
        let min: Int = count / 60
        let seconds: Int = count % 60
        var secondsString: String
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        return "\(min):\(secondsString)"
    }
}
