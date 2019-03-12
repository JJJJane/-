//
//  LoginViewController.swift
//  UI
//
//  Created by 陶子卓 on 2018/7/6.
//  Copyright © 2018年 CDDGame. All rights reserved.
//

import UIKit
let playersName=["玩家一","玩家二","玩家三","玩家四"]
class LoginViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playersName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playersName[row]
    }
    
    
    @IBOutlet weak var playerPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerPicker.delegate=self
        playerPicker.dataSource=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*override func touchesEnded(_ touches: Set<UITouch>, with withEvent: UIEvent!) {
        PlayerName.resignFirstResponder()
    }
    var playerName:String?
    @IBAction func Tapped(sender: Any) {
        PlayerName.resignFirstResponder()
        if PlayerName.text != nil {
            playerName=PlayerName.text!;
        }
    }*/
    var playerName: String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="gotoTable" {
            let index=playerPicker.selectedRow(inComponent: 0)
            players[index].state = true
            switch index {
            case 0:
                playerName="玩家一"
                id=1
            case 1:
                playerName="玩家二"
                id=2
            case 2:
                playerName="玩家三"
                id=3
            case 3:
                playerName="玩家四"
                id=4
            default:
                playerName=nil
                id=1
            }
            
            }
        }

    
}
    

