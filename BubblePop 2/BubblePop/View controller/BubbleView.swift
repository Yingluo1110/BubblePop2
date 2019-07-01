//
//  BubbleView.swift
//  BubblePop
//
//  Created by 羅穎 on 28/4/19.
//  Copyright © 2019 Ying LUO. All rights reserved.

import UIKit

class BubbleView: UIView{
    
    var points:Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = frame.size.width/2
        
        // set points and color for bubbles, as well as the probability for each color.
        
        let randomNum = arc4random()%100
        
        if randomNum<=5{
            backgroundColor = UIColor.black
            points = 10
        }else if randomNum<=15{
            backgroundColor = UIColor.blue
            points = 8
        }else if randomNum<=30{
            backgroundColor = UIColor.green
            points = 5
        }else if randomNum<=60{
            backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1)
            points = 2
        }else{
            backgroundColor = UIColor.red
            points = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
