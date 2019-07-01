//
//  GameSceneViewController.swift
//  BubblePop
//
//  Created by 羅穎 on 28/4/19.
//  Copyright © 2019 Ying LUO. All rights reserved.

import UIKit

class GameSceneViewController: UIViewController{
    
    @IBOutlet weak var bubbleContainerView: UIView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let scoreBoard = UserDefaults.standard.dictionary(forKey: "ScoreBoard")?.sorted(by: { (arg0, arg1) -> Bool in
        
        let (key, value) = arg0
        let (key1,value1) = arg1
        return (value as! Int) > (value1 as! Int)
    })
    
    
    // init game settings
    
    var allBubbles:[BubbleView] = []
    
    let bubbleRadius = 25
    
    var score = 0
    
    var leftTime = timeframe
    
    var lastColor:UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLeftLabel.text = "Time Left\n\(leftTime)"
        scoreLabel.text = "Score\n\(score)"
        highScoreLabel.text = "High Score\n\(scoreBoard?.first?.value as? Int ?? 0)"
        
        
        // Set timer for the game
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self](timer) in
            guard let `self` = self else{
                return
            }
            self.leftTime -= 1
            
            if self.leftTime < 0{
                timer.invalidate()
                
                self.saveScore()
                
                self.performSegue(withIdentifier: "showScoreBoard", sender: nil)
            }else{
            
                self.randomRemoveBubbleView()
                
        
                self.timeLeftLabel.text = "Time Left\n\(self.leftTime)"
                
                self.generateBubbleView(count: Int.random(in: 0...maxBubble-self.allBubbles.count))
            }
        }
    }
    
    // save score to scoreboard.
    func saveScore(){
        guard var scoreBoard = UserDefaults.standard.dictionary(forKey: "ScoreBoard") else{
            UserDefaults.standard.set([currentPlayerName!:score], forKey: "ScoreBoard")
            return
        }
        
        if let s = scoreBoard[currentPlayerName!] as? Int, s>score{
            
        }else{
            scoreBoard[currentPlayerName!] = score
            UserDefaults.standard.set(scoreBoard, forKey: "ScoreBoard")
        }
    }
    
    // refresh bubbles once a second.
    func randomRemoveBubbleView(){
        let removeCount = Int.random(in: 0...allBubbles.count)
        
        for _ in 0..<removeCount{
            let randomCount = Int.random(in: 0..<allBubbles.count)
            
            allBubbles.remove(at: randomCount).removeFromSuperview()
        }
    }
    
    // generate bubbles in assigned position.
    
    func generateBubbleView(count:Int){
        for _ in 0..<count{
            let pos = generateRandomPosition()
            let view = BubbleView(frame: CGRect(x: pos.width-CGFloat(bubbleRadius), y: pos.height-CGFloat(bubbleRadius), width: CGFloat(bubbleRadius)*2, height: CGFloat(bubbleRadius)*2))
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBubbleView(_:))))
            bubbleContainerView.addSubview(view)
            allBubbles.append(view)
        }
    }
    
    // function of tapping bubbles.
    
    @objc func tapBubbleView(_ gesture:UIGestureRecognizer){
        guard let sender = gesture.view as? BubbleView ,let points = sender.points else{
            return
        }
        
        if let lastColor = lastColor, lastColor == sender.backgroundColor!{
            score += Int(Double(points)*1.5)
        }else{
            score += points
        }
        
        if let highScore = scoreBoard?.first?.value as? Int , highScore>score{
            
        }else{
            highScoreLabel.text = "High Score\n\(score)"
        }
        
        scoreLabel.text = "Score\n\(score)"
        
        sender.removeFromSuperview()
    }
    
    func generateRandomPosition()->CGSize{
        while(true){
            let x = Int.random(in:Int(bubbleContainerView.frame.minX)+bubbleRadius...Int(bubbleContainerView.frame.maxX)-bubbleRadius)
            let y = Int.random(in: 25...Int(bubbleContainerView.frame.height)-25)
            
            if allBubbles.filter({ (bubbleView) -> Bool in
                return distanceBetweenBubbles(x1: Double(x), y1: Double(y), x2: Double(bubbleView.frame.midX), y2: Double(bubbleView.frame.midY)) <= Double(2*bubbleRadius)
            }).isEmpty{
                return CGSize(width: x, height: y)
            }
        }
        
    }
    
    func distanceBetweenBubbles(x1:Double,y1:Double,x2:Double,y2:Double)->Double{
        return sqrt(pow(x1-x2, 2)+pow(y1-y2, 2))
    }
}

extension GameSceneViewController:UIGestureRecognizerDelegate{
    
}
