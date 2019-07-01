//
//  ScoreBoardViewController.swift
//  BubblePop
//
//  Created by 羅穎 on 28/4/19.
//  Copyright © 2019 Ying LUO. All rights reserved.

import UIKit

class ScoreBoardViewController: UIViewController{
    @IBOutlet weak var scoreTable: UITableView!
    
    let scoreBoard = UserDefaults.standard.dictionary(forKey: "ScoreBoard")?.sorted(by: { (arg0, arg1) -> Bool in
        
        let (key, value) = arg0
        let (key1,value1) = arg1
        return (value as! Int) > (value1 as! Int)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTable.delegate = self
        scoreTable.dataSource = self
    }
}

extension ScoreBoardViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreBoard?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "score")
        cell.textLabel!.text = "\(scoreBoard![indexPath.row].key)"
        cell.detailTextLabel!.text = "\(scoreBoard![indexPath.row].value)"
        return cell
    }
    
    
}
