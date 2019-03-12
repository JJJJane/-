//
//  RankingViewController.swift
//  UI
//
//  Created by 陶子卓 on 2018/7/8.
//  Copyright © 2018年 CDDGame. All rights reserved.
//


import UIKit

class RankingViewController: UIViewController {
    
    
    
    @IBOutlet weak var order1: UILabel!
    
    @IBOutlet weak var Name1: UILabel!
    
    @IBOutlet weak var point1: UILabel!
    
    @IBOutlet weak var order2: UILabel!
    
    @IBOutlet weak var Name2: UILabel!
    
    @IBOutlet weak var point2: UILabel!
    
    @IBOutlet weak var order3: UILabel!
    
    @IBOutlet weak var Name3: UILabel!
    
    @IBOutlet weak var point3: UILabel!
    
    @IBOutlet weak var order4: UILabel!
    
    @IBOutlet weak var Name4: UILabel!
    
    @IBOutlet weak var point4: UILabel!
    
    
    
    var rankNumber: String?
    var playerName: String?
    var totalPoint: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        order1.text="\(players[0].rank)"
        Name1.text=players[0].name
        point1.text="\(players[0].mark)"
        order2.text="\(players[1].rank)"
        Name2.text=players[1].name
        point2.text="\(players[1].mark)"
        order3.text="\(players[2].rank)"
        Name3.text=players[2].name
        point3.text="\(players[2].mark)"
        order4.text="\(players[3].rank)"
        Name4.text=players[3].name
        point4.text="\(players[3].mark)"
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
