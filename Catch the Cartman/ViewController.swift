//
//  ViewController.swift
//  Catch the Cartman
//
//  Created by Atıl Samancıoğlu on 09/12/2016.
//  Copyright © 2016 Atıl Samancıoğlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    var score = 0
    var counter = 30
    
    var timer = Timer()
    var hideTimer = Timer()
    
    var imageArray = [UIImageView]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
    
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let highestScore = highScore as? Int {
            highScoreLabel.text = String(highestScore)
        }
        
    
        
        //adding gestureRecognizers to images
        
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        image7.addGestureRecognizer(recognizer7)
        image8.addGestureRecognizer(recognizer8)
        image9.addGestureRecognizer(recognizer9)
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        
        //timer creation
        
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideImages), userInfo: nil, repeats: true)
        
        //imagesArray creation
        imageArray.append(image1)
        imageArray.append(image2)
        imageArray.append(image3)
        imageArray.append(image4)
        imageArray.append(image5)
        imageArray.append(image6)
        imageArray.append(image7)
        imageArray.append(image8)
        imageArray.append(image9)
        
        hideImages()
        
        
    }
    
    func increaseScore() {
        
        //what happens when we click on images
        score = score + 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    func countDown() {
        
        counter = counter - 1
        timerLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            
            //saving highscores
            
            if self.score > Int(highScoreLabel.text!)! {
            UserDefaults.standard.set(self.score, forKey: "highscore")
            highScoreLabel.text = String(self.score)
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Your 30 Seconds Is Done", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                
                self.timerLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideImages), userInfo: nil, repeats: true)

            })
            alert.addAction(replay)
            
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    func hideImages() {
        
        for image in imageArray {
            image.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(imageArray.count - 1)))
        imageArray[randomNumber].isHidden = false
        
        
    }
    

  
  
}

