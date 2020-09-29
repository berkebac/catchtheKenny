//
//  ViewController.swift
//  catchTheKenny
//
//  Created by Berke Baç on 29.09.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    //Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var highScore = 0
    
    
    //Views
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    @IBOutlet weak var kenny5: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        
        //Highscore check
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighscore as? Int{
            highScore=newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }


        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()
        
        
    }
    
    @objc func hideKenny() {
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    @objc func timerFunction(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        //High Score
        
        if self.score > self.highScore {
            self.highScore = self.score
            highScoreLabel.text = "Highscore: \(highScore)"
            UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
        }
        
        
        
        
        //Alert
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            let alert = UIAlertController(title: "Time is over!", message: "Do u want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Time: \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }

}

