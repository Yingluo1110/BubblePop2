//
//  ViewController.swift
//  BubblePop
//
//  Created by 羅穎 on 28/4/19.
//  Copyright © 2019 Ying LUO. All rights reserved.

import UIKit

var currentPlayerName:String?

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startGame(_ sender: UIButton) {
        if nameTextField.text!.isEmpty{
            let alert = UIAlertController(title: "Name is empty", message: "you must input your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OKOK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            self.show(alert, sender: nil)
        }else{
            currentPlayerName = nameTextField.text!
            performSegue(withIdentifier: "showGame", sender: nil)
        }
    }
    
}

