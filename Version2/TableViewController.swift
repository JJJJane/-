//
//  ViewController.swift
//  Version1
//
//  Created by TNT on 2018/7/8.
//  Copyright © 2018年 TNT. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class TableViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, UITextFieldDelegate {
    var receiveText:String! = "init"
    var receiveCard:[card]! = defaultCards1
    var sendText:String!
    var sendCard:[card]!
    
    @IBAction func connectToPeersPressed(_ sender: Any) {
        showConnectionPrompt()
    }
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    let serviceType = "text-peer"
    
    /***************************以上为蓝牙内容********************************/
    func operate(card1 : UIImageView, card2 : UIImageView, names : inout[String]){
        if card1.image?.accessibilityIdentifier == nil{
            let name = card2.image?.accessibilityIdentifier
            remove(names: &names, tag: name!)
        }else{
            let name = card1.image?.accessibilityIdentifier
            names.append(name!)
        }
    }
    @IBAction func update(_ sender: Any) {
        lastShow = returnMessage().1-1
        gameTurn = returnMessage().1
        validateShow.cards = returnMessage().0
        print(returnMessage())
        if gameTurn != initShow {
            substractCard(currentCards: &players[lastShow].myCards, showCards: validateShow.cards)}
        print("validate:")
        print(validateShow.cards)
        gameTurnDisplay.text = "玩家" + String(gameTurn%4+1) + "出牌"
        showstate.text = "出牌成功"
        initshowCard()
        if returnMessage().2==1{
            gameState=1
            showCard.isUserInteractionEnabled = false
            showstate.text = "player"+String(lastShow+1)+"是赢家！！"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        /*****蓝牙**********/
        if gameState==0||gameState==2 {
            gotoRanking.setTitle("", for: .normal)
        }
        if gameState==1 {
            gotoRanking.setTitle("查看成绩", for: .normal)
        }
        /******以上为查看排名的按钮*******/
        if id==1{
            left.text="玩家4"
            top.text="玩家3"
            right.text="玩家2"
            down.text="玩家1"
        }else if id==2{
            left.text="玩家1"
            top.text="玩家4"
            right.text="玩家3"
            down.text="玩家2"
        }else if id==3{
            left.text="玩家2"
            top.text="玩家2"
            right.text="玩家4"
            down.text="玩家3"
        }else if id==4{
            left.text="玩家3"
            top.text="玩家2"
            right.text="玩家1"
            down.text="玩家4"
        }
        /******以上为玩家信息打印*********/
        showCard.isUserInteractionEnabled = true
        firstcard.isUserInteractionEnabled = true
        secondcard.isUserInteractionEnabled = true
        thirdcard.isUserInteractionEnabled = true
        fourthcard.isUserInteractionEnabled = true
        fifthcard.isUserInteractionEnabled = true
        sixthcard.isUserInteractionEnabled = true
        seventhcard.isUserInteractionEnabled = true
        eighthcard.isUserInteractionEnabled = true
        ninthcard.isUserInteractionEnabled = true
        tenthcard.isUserInteractionEnabled = true
        eleventhcard.isUserInteractionEnabled = true
        twelfthcard.isUserInteractionEnabled = true
        thirteenthcard.isUserInteractionEnabled = true
        
        let tapshowimg = UITapGestureRecognizer(target: self, action: #selector(tapshow))
        let tapfirstcard = UITapGestureRecognizer(target: self, action: #selector(tapcard1))
        let tapsecondcard = UITapGestureRecognizer(target: self, action: #selector(tapcard2))
        let tapthirdcard = UITapGestureRecognizer(target: self, action: #selector(tapcard3))
        let tapfourthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard4))
        let tapfifthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard5))
        let tapsixthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard6))
        let tapseventhcard = UITapGestureRecognizer(target: self, action: #selector(tapcard7))
        let tapeighthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard8))
        let tapninthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard9))
        let taptenthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard10))
        let tapeleventhcard = UITapGestureRecognizer(target: self, action: #selector(tapcard11))
        let taptwelfthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard12))
        let tapthirteenthcard = UITapGestureRecognizer(target: self, action: #selector(tapcard13))
        
        showCard.addGestureRecognizer(tapshowimg)
        firstcard.addGestureRecognizer(tapfirstcard)
        secondcard.addGestureRecognizer(tapsecondcard)
        thirdcard.addGestureRecognizer(tapthirdcard)
        fourthcard.addGestureRecognizer(tapfourthcard)
        fifthcard.addGestureRecognizer(tapfifthcard)
        sixthcard.addGestureRecognizer(tapsixthcard)
        seventhcard.addGestureRecognizer(tapseventhcard)
        eighthcard.addGestureRecognizer(tapeighthcard)
        ninthcard.addGestureRecognizer(tapninthcard)
        tenthcard.addGestureRecognizer(taptenthcard)
        eleventhcard.addGestureRecognizer(tapeleventhcard)
        twelfthcard.addGestureRecognizer(taptwelfthcard)
        thirteenthcard.addGestureRecognizer(tapthirteenthcard)
        /*******以上为点击牌的图片赋值和动作****/
        gameTurnDisplay.text = "玩家"+String(gameTurn%4+1)+"出牌"
        initCardImg()
        initshowCard()
        /********以上为初始化按钮信息********/
        lastShow = returnMessage().1-1
        gameTurn = returnMessage().1
        validateShow.cards = returnMessage().0
        if gameTurn != initShow {
            substractCard(currentCards: &players[lastShow].myCards, showCards: validateShow.cards)}
        if returnMessage().2==1{
            gameState=1
            showCard.isUserInteractionEnabled = false
            showstate.text = "player"+String(lastShow+1)+"是赢家！！"
        }
    }
   
    @IBOutlet weak var gotoRanking: UIButton!
    @IBOutlet weak var gameTurnDisplay: UILabel!
    @IBOutlet weak var showstate: UILabel!
    @IBOutlet weak var showCard: UIImageView!
    //绑定玩家姓名
    @IBOutlet weak var left: UILabel!
    @IBOutlet weak var top: UILabel!
    @IBOutlet weak var right: UILabel!
    @IBOutlet weak var down: UILabel!
    //下方牌
    @IBOutlet weak var tempcard: UIImageView!
    @IBOutlet weak var firstcard: UIImageView!
    @IBOutlet weak var secondcard: UIImageView!
    @IBOutlet weak var thirdcard: UIImageView!
    @IBOutlet weak var fourthcard: UIImageView!
    @IBOutlet weak var fifthcard: UIImageView!
    @IBOutlet weak var sixthcard: UIImageView!
    @IBOutlet weak var seventhcard: UIImageView!
    @IBOutlet weak var eighthcard: UIImageView!
    @IBOutlet weak var ninthcard: UIImageView!
    @IBOutlet weak var tenthcard: UIImageView!
    @IBOutlet weak var eleventhcard: UIImageView!
    @IBOutlet weak var twelfthcard: UIImageView!
    @IBOutlet weak var thirteenthcard: UIImageView!
    //选择的牌
    @IBOutlet weak var firstshowingcard: UIImageView!
    @IBOutlet weak var secondshowingcard: UIImageView!
    @IBOutlet weak var thirdshowingcard: UIImageView!
    @IBOutlet weak var fourthshowingcard: UIImageView!
    @IBOutlet weak var fifthshowingcard: UIImageView!
    @IBOutlet weak var sixthshowingcard: UIImageView!
    @IBOutlet weak var seventhshowingcard: UIImageView!
    @IBOutlet weak var eighthshowingcard: UIImageView!
    @IBOutlet weak var ninthshowingcard: UIImageView!
    @IBOutlet weak var tenthshowingcard: UIImageView!
    @IBOutlet weak var eleventhshowingcard: UIImageView!
    @IBOutlet weak var twelfthshowingcard: UIImageView!
    @IBOutlet weak var thirteenthshowingcard: UIImageView!
    //上方牌
    @IBOutlet weak var firstshowcard: UIImageView!
    @IBOutlet weak var secondshowcard: UIImageView!
    @IBOutlet weak var thirdshowcard: UIImageView!
    @IBOutlet weak var fourthshowcard: UIImageView!
    @IBOutlet weak var fifthshowcard: UIImageView!
    
    func setMessage(cards:[card],gameturn:Int,End:Int){
        sendCard=cards
        gameTurn=gameturn
        end=End
    }
    func MessageToString(){//传牌组，跟UI接口
        let string1 = "number:"
        var string2 = ""
        let string3 = " color:"
        var string4 = ""
        let string5 = "gameTurn:"
        let string6 = String(gameTurn)
        for i in sendCard{
            string2.append(" "+String(i.number))
        }
        for j in sendCard{
            string4.append(" "+String(j.color))
        }
        let returnString = string1 + string2 + string3 + string4+" "+string5+" "+string6+" end: "+String(end)
        sendText=returnString
    }
    func StringToMessage(){
        var array=receiveText?.components(separatedBy:" ")
        var locate:Int = -1
        for (index,item) in (array?.enumerated())!{
            if item=="color:"{
                locate=index
            }
        }
        var temp=locate
        var count=0
        while(temp>1){
            receiveCard[count].number=Int((array![count+1] as NSString).intValue)
            temp-=1
            count+=1
        }
        count=0
        temp=locate
        while(temp>1){
            receiveCard[count].color=Int((array![locate+count+1] as NSString).intValue)
            temp-=1
            count+=1
        }
        for (index,item) in (array?.enumerated())!{
            if item=="gameTurn:"{
                gameTurn=Int(array![index+1])!
            }
        }
        
        for (index,item) in (array?.enumerated())!{
            if item=="end:"{
                end=Int(array![index+1])!
            }
        }
    }
    
    public func returnMessage()->([card],Int,Int){//返回接口,用这个就可以了
        StringToMessage()
        for (index,item) in receiveCard.enumerated(){
            print(item.number)
        }
        return (receiveCard,gameTurn,end)
    }
    //show的点击事件
    @objc func tapshow(sender:UITapGestureRecognizer){
        if gameTurn%4==id-1{
            players[id-1].myShowcards.updateCardCom(cards: strings_to_cards(card_names : names))
            let show = (gameTurn == initShow || lastShow%4 == gameTurn%4) ? showingCard(playerCard: &players[id-1].myCards, showCard: players[id-1].myShowcards, validateCard : &validateShow):showingCard(previousCard: validateShow, playerCard: &players[id-1].myCards, showCard: players[id-1].myShowcards, validateCard: &validateShow)
            //如果出牌失败，继续选择，当前玩家不变，即gameTurn不变
            if !show{
                showstate.text="出牌不合规则"
            }else{
                lastShow = gameTurn
                gameTurn = gameTurn + 1
                initshowCard()
                initCardImg()
                clearshow()
                clearselect(names : &names)
                gameTurnDisplay.text = "玩家"+String(gameTurn%4+1)+"出牌"
                showstate.text = "出牌成功"
                if nullCard(cards: players[id-1].myCards){
                    showstate.text = "游戏结束"
                    gameState = 1
                    end = 1
                }
                print(validateShow.cards)
                /*********************以下为蓝牙部分*****************/
                setMessage(cards : validateShow.cards, gameturn : gameTurn, End : end)//set函数
                MessageToString()
                guard sendText == nil else {
                    sendMessage(message: sendText)
                    return
                }
            }
        }
    }
    func cardsToString(cards : [card]) -> String {//传牌组，跟UI接口
        let string1 = "number:"
        var string2 = ""
        let string3 = " color:"
        var string4 = ""
        let string5 = "gameTurn:"
        gameTurn+=1
        let string6 = String(gameTurn)
        for i in cards{
            string2.append(" "+String(i.number))
        }
        for j in cards{
            string4.append(" "+String(j.color))
        }
        let returnString = string1 + string2 + string3 + string4+" "+string5+" "+string6+" end: "+String(end)
        return returnString
    }
    
    @IBAction func passButton(_ sender: Any) {
        if gameTurn%4==id-1&&(gameState != 2){
            gameTurn = gameTurn + 1
            gameTurnDisplay.text = "玩家"+String(gameTurn%4+1)+"出牌"
            showstate.text="下一位"
            /*********蓝牙*************/
            setMessage(cards : validateShow.cards, gameturn : gameTurn, End : end)//set函数
            MessageToString()
            guard sendText == nil else {
                sendMessage(message: sendText)
                return
            }
        }
    }
    func clearselect(names : inout [String]){
        names = []
    }
    func clearshow(){
        firstshowingcard.image = UIImage(named: "000")
        secondshowingcard.image = UIImage(named: "000")
        thirdshowingcard.image = UIImage(named: "000")
        fourthshowingcard.image = UIImage(named: "000")
        fifthshowingcard.image = UIImage(named: "000")
        sixthshowingcard.image = UIImage(named: "000")
        seventhshowingcard.image = UIImage(named: "000")
        eighthshowingcard.image = UIImage(named: "000")
        ninthshowingcard.image = UIImage(named: "000")
        tenthshowingcard.image = UIImage(named: "000")
        eleventhshowingcard.image = UIImage(named: "000")
        twelfthshowingcard.image = UIImage(named: "000")
        thirteenthshowingcard.image = UIImage(named: "000")
    }
    func initImg(card : UIImageView, name : String){
        card.image = UIImage(named: name)
        card.image?.accessibilityIdentifier = name
    }
    func initCardImg(){
        let handcards1 = handcards(cards: players[id-1].myCards)
        initImg(card: firstcard, name: handcards1.card_names[0])
        initImg(card: secondcard, name: handcards1.card_names[1])
        initImg(card: thirdcard, name: handcards1.card_names[2])
        initImg(card: fourthcard, name: handcards1.card_names[3])
        initImg(card: fifthcard, name: handcards1.card_names[4])
        initImg(card: sixthcard, name: handcards1.card_names[5])
        initImg(card: seventhcard, name: handcards1.card_names[6])
        initImg(card: eighthcard, name: handcards1.card_names[7])
        initImg(card: ninthcard, name: handcards1.card_names[8])
        initImg(card: tenthcard, name: handcards1.card_names[9])
        initImg(card: eleventhcard, name: handcards1.card_names[10])
        initImg(card: twelfthcard, name: handcards1.card_names[11])
        initImg(card: thirteenthcard, name: handcards1.card_names[12])
    }
    func initshowCard(){
        let showcard = handcardsv2(cards: validateShow.cards)
        firstshowcard.image = UIImage(named: showcard.card_names[0])
        secondshowcard.image = UIImage(named: showcard.card_names[1])
        thirdshowcard.image = UIImage(named: showcard.card_names[2])
        fourthshowcard.image = UIImage(named: showcard.card_names[3])
        fifthshowcard.image = UIImage(named: showcard.card_names[4])
    }
    @objc func tapcard1(sender: UITapGestureRecognizer) {
        operate(card1: firstcard, card2: firstshowingcard, names: &names)
        tempcard.image = firstshowingcard.image
        firstshowingcard.image = firstcard.image
        firstcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard2(sender: UITapGestureRecognizer) {
        operate(card1: secondcard, card2: secondshowingcard, names: &names)
        tempcard.image = secondshowingcard.image
        secondshowingcard.image = secondcard.image
        secondcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard3(sender: UITapGestureRecognizer) {
        operate(card1: thirdcard, card2: thirdshowingcard, names: &names)
        tempcard.image = thirdshowingcard.image
        thirdshowingcard.image = thirdcard.image
        thirdcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
        
    }
    @objc func tapcard4(sender: UITapGestureRecognizer) {
        operate(card1: fourthcard, card2: fourthshowingcard, names: &names)
        tempcard.image = fourthshowingcard.image
        fourthshowingcard.image = fourthcard.image
        fourthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard5(sender: UITapGestureRecognizer) {
        operate(card1: fifthcard, card2: fifthshowingcard, names: &names)
        tempcard.image = fifthshowingcard.image
        fifthshowingcard.image = fifthcard.image
        fifthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard6(sender: UITapGestureRecognizer) {
        operate(card1: sixthcard, card2: sixthshowingcard, names: &names)
        tempcard.image = sixthshowingcard.image
        sixthshowingcard.image = sixthcard.image
        sixthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard7(sender: UITapGestureRecognizer) {
        operate(card1: seventhcard, card2: seventhshowingcard, names: &names)
        tempcard.image = seventhshowingcard.image
        seventhshowingcard.image = seventhcard.image
        seventhcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard8(sender: UITapGestureRecognizer) {
        operate(card1: eighthcard, card2: eighthshowingcard, names: &names)
        tempcard.image = eighthshowingcard.image
        eighthshowingcard.image = eighthcard.image
        eighthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard9(sender: UITapGestureRecognizer) {
        operate(card1: ninthcard, card2: ninthshowingcard, names: &names)
        tempcard.image = ninthshowingcard.image
        ninthshowingcard.image = ninthcard.image
        ninthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard10(sender: UITapGestureRecognizer) {
        operate(card1: tenthcard, card2: tenthshowingcard, names: &names)
        tempcard.image = tenthshowingcard.image
        tenthshowingcard.image = tenthcard.image
        tenthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard11(sender: UITapGestureRecognizer) {
        operate(card1: eleventhcard, card2: eleventhshowingcard, names: &names)
        tempcard.image = eleventhshowingcard.image
        eleventhshowingcard.image = eleventhcard.image
        eleventhcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard12(sender: UITapGestureRecognizer) {
        operate(card1: twelfthcard, card2: twelfthshowingcard, names: &names)
        tempcard.image = twelfthshowingcard.image
        twelfthshowingcard.image = twelfthcard.image
        twelfthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    @objc func tapcard13(sender: UITapGestureRecognizer) {
        operate(card1: thirteenthcard, card2: thirteenthshowingcard, names: &names)
        tempcard.image = thirteenthshowingcard.image
        thirteenthshowingcard.image = thirteenthcard.image
        thirteenthcard.image = tempcard.image
        tempcard.image = UIImage(named: "000")
        print(names)
    }
    func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func startHosting(action: UIAlertAction) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
        print("Started hosting")
    }
    func joinSession(action: UIAlertAction) {
        let mcBrowser = MCBrowserViewController(serviceType: serviceType, session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
        print("MCBrowser presented")
    }
    
    func startHosting() {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
        print("Started hosting")
    }
    
    func joinSession() {
        let mcBrowser = MCBrowserViewController(serviceType: serviceType, session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
        print("MCBrowser presented")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("Started receiving stream with name \(streamName) from \(peerID.displayName). Stream: \(stream)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Started receiving resource with name \(resourceName) from \(peerID.displayName). Progress: \(progress)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("Finished receiving resource with name \(resourceName) from \(peerID.displayName). LocalURL: \(localURL). Error \(String(describing: error))")
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        print("Host was selected")
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        print("MCBrowser was cancelled")
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            if let msg = String(data: data, encoding: String.Encoding.utf8) {
                self.receiveText = msg//接受到的字符流
                print(self.receiveText)
            } else {
                print("Error converting message data to text")
            }
        }
    }
    
    func sendMessage(message: String) {
        if mcSession.connectedPeers.count > 0 {
            if let stringToData = message.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    try mcSession.send(stringToData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            } else {
                print("Error converting message text to data")
            }
        } else {
            print("No peers connected: \(mcSession.connectedPeers.count)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

