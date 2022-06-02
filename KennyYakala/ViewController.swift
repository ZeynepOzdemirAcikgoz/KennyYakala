//
//  ViewController.swift
//  KennyYakala
//
//  Created by Zeynep Özdemir Açıkgöz on 1.06.2022.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var panterArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var panter1: UIImageView!
    @IBOutlet weak var panter2: UIImageView!
    @IBOutlet weak var panter3: UIImageView!
    @IBOutlet weak var panter4: UIImageView!
    @IBOutlet weak var panter5: UIImageView!
    @IBOutlet weak var panter6: UIImageView!
    @IBOutlet weak var panter7: UIImageView!
    @IBOutlet weak var panter8: UIImageView!
    @IBOutlet weak var panter9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //highScore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil{
            
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newscore = storedHighScore as? Int{
            highScore=newscore
            highScoreLabel.text = "HighScore: \(highScore)"
            
        }
        
        //images
        panter1.isUserInteractionEnabled = true
        panter2.isUserInteractionEnabled = true
        panter3.isUserInteractionEnabled = true
        panter4.isUserInteractionEnabled = true
        panter5.isUserInteractionEnabled = true
        panter6.isUserInteractionEnabled = true
        panter7.isUserInteractionEnabled = true
        panter8.isUserInteractionEnabled = true
        panter9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    
        panter1.addGestureRecognizer(recognizer1)
        panter2.addGestureRecognizer(recognizer2)
        panter3.addGestureRecognizer(recognizer3)
        panter4.addGestureRecognizer(recognizer4)
        panter5.addGestureRecognizer(recognizer5)
        panter6.addGestureRecognizer(recognizer6)
        panter7.addGestureRecognizer(recognizer7)
        panter8.addGestureRecognizer(recognizer8)
        panter9.addGestureRecognizer(recognizer9)
        
        panterArray = [panter1, panter2, panter3, panter4, panter5,panter6,panter7, panter8, panter9]
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidepanter), userInfo: nil, repeats: true)
        
    hidepanter()
    
    }
    
    @objc func hidepanter(){
        for panter in panterArray{
            panter.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(panterArray.count - 1)))
        panterArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            for panter in panterArray{
                panter.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore{
                self.highScore=self.score
                highScoreLabel.text = "HighScore: \(self.highScore)"
                UserDefaults.standard.set(self.score, forKey: "hifhScore")
                
                
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidepanter), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    

}

