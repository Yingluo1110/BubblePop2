//
//  SettingViewController.swift
//  BubblePop
//
//  Created by 羅穎 on 28/4/19.
//  Copyright © 2019 Ying LUO. All rights reserved.

import UIKit

var timeframe:Int{
    get{
        return UserDefaults.standard.object(forKey: "TimeFrame") as? Int ?? 60
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "TimeFrame")
    }
}

var maxBubble:Int{
    get{
        return UserDefaults.standard.object(forKey: "MaxBubble") as? Int ?? 15
    }
    set{
        UserDefaults.standard.set(newValue, forKey: "MaxBubble")
    }
}

class SettingViewController: UIViewController{
    
    @IBOutlet weak var timeFrameSlider: UISlider!
    @IBOutlet weak var maxBubbleLabel: UILabel!
    @IBOutlet weak var maxBubbleSlider: UISlider!
    @IBOutlet weak var timeFrameLabel: UILabel!
    
    let timeFrameLower = 30
    let timeFrameUpper = 90
    
    let bubbleNumLower = 5
    let bubbleNumUpper = 25
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maxBubbleLabel.text = "\(maxBubble)"
        timeFrameLabel.text = "\(timeframe)"
        timeFrameSlider.value = Float(timeframe)/Float(timeFrameLower+timeFrameUpper)
        maxBubbleSlider.value = Float(maxBubble)/Float(bubbleNumLower+bubbleNumUpper)
    }
    
    @IBAction func valueChanged(_ sender: UISlider) {
        if sender == timeFrameSlider{
            timeframe = Int(sender.value*60+30)
            timeFrameLabel.text = "\(timeframe)"
        }else{
            maxBubble = Int(sender.value*20+5)
            maxBubbleLabel.text = "\(maxBubble)"
        }
    }
}
