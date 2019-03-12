//
//  CDD.swift
//  study
//
//  Created by TNT on 2018/7/7.
//  Copyright © 2018年 TNT. All rights reserved.
//

import Foundation

var gameState = 0
var id = 1
var lastShow = 0
var end = 0

var defaultCard = card( color : 99, number : 99)
var defaultCards1 = [card] (repeating : defaultCard, count : 5)
//var defaultCards = [card] (repeating : defaultCard, count : 13)
//var defaultShow = card_combination(cards: defaultCards)
var validateShow = card_combination(cards : defaultCards1)
var names : [String]=[]
var players = initC()
var initShow = identifyBlock3(players : players)
var gameTurn = initShow
func initC()->[player]{
    let card1 = card(color: 0, number: 0)
    var totCard = [card](repeating: card1, count: 52)
    var count = 0
    for i in 0...3{
        for j in 3...15{
            totCard[count].color = i;
            totCard[count].number = j;
            count=count+1
        }
    }
    let cards1 = [totCard[1],totCard[4],totCard[7],totCard[8],totCard[9],totCard[24],totCard[34],totCard[35],
    totCard[36],totCard[15],totCard[17],totCard[45],totCard[50]]
    let cards2 = [totCard[0],totCard[2],totCard[3],totCard[5],totCard[20],totCard[21],totCard[30],totCard[36],
                  totCard[32],totCard[16],totCard[19],totCard[46],totCard[47]]
    let cards3 = [totCard[6],totCard[11],totCard[14],totCard[22],totCard[25],totCard[27],totCard[28],totCard[29],
                  totCard[44],totCard[40],totCard[41],totCard[51],totCard[33]]
    let cards4 = [totCard[10],totCard[12],totCard[13],totCard[18],totCard[23],totCard[24],totCard[26],totCard[31],
                  totCard[37],totCard[38],totCard[39],totCard[42],totCard[43]]
    let player1 = player(id: 1, name: "player1", mark: 0, rank: 0, state: true, myCards: cards1, myShowcards: validateShow)
    let player2 = player(id: 2, name: "player2", mark: 0, rank: 0, state: true, myCards: cards2, myShowcards: validateShow)
    let player3 = player(id: 3, name: "player3", mark: 0, rank: 0, state: true, myCards: cards3, myShowcards: validateShow)
    let player4 = player(id: 4, name: "player4", mark: 0, rank: 0, state: true, myCards: cards4, myShowcards: validateShow)
    let players = [player1, player2, player3, player4]
    return players
}
/**********************基本结构***********************/
struct card {
    var color: Int //0:♦️ 1:♣️ 2:♥️ 3:♠️
    var number: Int //3:3 4:4 ～ 10:10 11:J 12:Q 13:K 14:A 15:2
}
class player{
    var id: Int
    var name: String
    var mark: Int
    var rank: Int
    var state: Bool
    var myCards: [card]
    var myShowcards: card_combination
    init(id: Int, name: String, mark: Int, rank: Int, state: Bool, myCards: [card], myShowcards: card_combination){
        self.id = id
        self.name = name
        self.mark = mark
        self.rank = rank
        self.state = state
        self.myCards = myCards
        self.myShowcards = myShowcards
    }
}
class handcards {
    var cards: [card]
    func onSort(s1:card, s2:card) -> Bool{
        if s1.number < s2.number {
            return true
        }
        if s1.number > s2.number {
            return false
        }
        if s1.number == s2.number {
            return s1.color < s2.color
        }
        else {
            return false
        }
    }
    var card_names: [String] = ["000","000","000","000","000","000","000","000","000","000","000","000","000"]
    init(cards: [card]) {
        self.cards = cards
        self.cards.sort(by: onSort)
        if cards.count>0{
        for i in 0...cards.count-1 {
            self.card_names[i] = String(self.cards[i].number)+String(self.cards[i].color)
            if self.card_names[i] == "9999" {
                self.card_names[i] = "000"
            }
        }
    }
    }
    func setcard(card_number: Int, card: card) {
        self.cards[card_number] = card
        self.card_names[card_number] = String(cards[card_number].number)+String(cards[card_number].color)
        if self.card_names[card_number] == "9999" {
            self.card_names[card_number] = "000"
        }
        self.cards.sort(by: onSort)
    }
    func update(currentcards: [card]) {
        self.cards = currentcards
        self.cards.sort(by: onSort)
        for i in 0...cards.count-1 {
            self.card_names[i] = String(self.cards[i].number)+String(self.cards[i].color)
            if self.card_names[i] == "9999" {
                self.card_names[i] = "000"
            }
        }
    }
}
class handcardsv2 {
    var cards: [card]
    func onSort(s1:card, s2:card) -> Bool{
        if s1.number < s2.number {
            return true
        }
        if s1.number > s2.number {
            return false
        }
        if s1.number == s2.number {
            return s1.color < s2.color
        }
        else {
            return false
        }
    }
    var card_names: [String] = ["000","000","000","000","000"]
    init(cards: [card]) {
        self.cards = cards
        self.cards.sort(by: onSort)
        if cards.count>0{
            for i in 0...4 {
                self.card_names[i] = String(self.cards[i].number)+String(self.cards[i].color)
                if self.card_names[i] == "9999" {
                    self.card_names[i] = "000"
                }
            }
        }
    }
    func setcard(card_number: Int, card: card) {
        self.cards[card_number] = card
        self.card_names[card_number] = String(cards[card_number].number)+String(cards[card_number].color)
        if self.card_names[card_number] == "9999" {
            self.card_names[card_number] = "000"
        }
        self.cards.sort(by: onSort)
    }
    func update(currentcards: [card]) {
        self.cards = currentcards
        self.cards.sort(by: onSort)
        for i in 0...cards.count-1 {
            self.card_names[i] = String(cards[i].number)+String(cards[i].color)
            if self.card_names[i] == "9999" {
                self.card_names[i] = "000"
            }
        }
    }
}
/*****************************************************/


/************************牌的组合***********************/
struct card_combination {
    var cards: [card] = []
    var amount: Int
    var combination_number: Int
    //0:单张 1:一对 2:三个 3:杂顺 4:同花顺 5:同花五 6:三个带一对 7:四个带单张 8:错误的牌型
    init(cards: [card]) {
        self.cards = cards
        self.amount = cards.count
        self.combination_number = check_combination(cards: cards, amount: amount)
    }
    mutating func updateCardCom(cards: [card]) {
        self.cards = cards
        self.amount = cards.count
        self.combination_number = check_combination(cards: cards, amount: amount)
    }
}
func check_combination(cards: [card], amount: Int) -> Int {
    if check_comb0(cards: cards, amount: amount) {
        return 0
    }
    else if check_comb1(cards: cards, amount: amount) {
        return 1
    }
    else if check_comb2(cards: cards, amount: amount) {
        return 2
    }
    else if check_comb3(cards: cards, amount: amount) {
        return 3
    }
    else if check_comb4(cards: cards, amount: amount) {
        return 4
    }
    else if check_comb5(cards: cards, amount: amount) {
        return 5
    }
    else if check_comb6(cards: cards, amount: amount) {
        return 6
    }
    else if check_comb7(cards: cards, amount: amount) {
        return 7
    }
    return 8
}
//单张
func check_comb0(cards: [card], amount: Int) -> Bool {
    if amount != 1 {
        return false
    }
    return true
}
//一对
func check_comb1(cards: [card], amount: Int) -> Bool {
    if amount != 2 {
        return false
    }
    if cards[0].number != cards[1].number {
        return false
    }
    return true
}
//三个
func check_comb2(cards: [card], amount: Int) -> Bool {
    if amount != 3 {
        return false
    }
    if cards[0].number != cards[1].number || cards[0].number != cards[2].number {
        return false
    }
    return true
}
//顺子
func check_comb_shun(cards: [card], amount: Int) -> Bool {
    if amount != 5 {
        return false
    }
    if cards[0].number+1 != cards[1].number ||
        cards[1].number+1 != cards[2].number ||
        cards[2].number+1 != cards[3].number ||
        cards[3].number+1 != cards[4].number {
        return false
    }
    if cards[1].number == 14 || cards[2].number == 14 || cards[3].number == 14 {
        return false
    }
    return true
}
//杂顺
func check_comb3(cards: [card], amount: Int) -> Bool {
    if check_comb_shun(cards: cards, amount: amount) != true {
        return false
    }
    if cards[0].color == cards[1].color && cards[0].color == cards[2].color && cards[0].color == cards[3].color && cards[0].color == cards[4].color {
        return false
    }
    return true
}
//同花顺
func check_comb4(cards: [card], amount: Int) -> Bool {
    if check_comb_shun(cards: cards, amount: amount) != true {
        return false
    }
    if cards[0].color != cards[1].color || cards[0].color != cards[2].color || cards[0].color != cards[3].color || cards[0].color != cards[4].color {
        return false
    }
    return true
}
//同花五
func check_comb5(cards: [card], amount: Int) -> Bool {
    if amount != 5 {
        return false
    }
    if check_comb_shun(cards: cards, amount: amount) {
        return false
    }
    if cards[0].color != cards[1].color || cards[0].color != cards[2].color || cards[0].color != cards[3].color || cards[0].color != cards[4].color {
        return false
    }
    return true
}
//三个带一对
func check_comb6(cards: [card], amount: Int) -> Bool {
    if amount != 5 {
        return false
    }
    if cards[0].number != cards[1].number || cards[3].number != cards[4].number && cards[1].number != cards[2].number && cards[3].number != cards[2].number {
        return false
    }
    return true
}
//四个带单张
func check_comb7(cards: [card], amount: Int) -> Bool {
    if amount != 5 {
        return false
    }
    if cards[0].number == cards[1].number && cards[0].number == cards[2].number && cards[0].number == cards[3].number || cards[1].number == cards[2].number && cards[1].number == cards[3].number && cards[1].number == cards[4].number {
        return false
    }
    return true
}
/*****************************************************/

/*****************8检查牌是否比上家大********************/
func flagNumber( A:[card], B:[card],N:Int)->Int{
    var count=0
    if A[0].number>B[0].number {return -1}
    while A[count].number==B[count].number{
        if A[count].number<B[count].number {return count}
        else if count==N-1{
            return N-1
        }
        else {count=count+1}
    }
    return -1
}
func JudgeColor(count:Int,A:[card],B:[card])->Bool{//计算在count处花色比较大小
    return A[count].color<B[count].color
}
var tempCard=card(color: 0, number: 0)//给牌数组当作初始牌

func IsBigger(previousCard:card_combination,currentCard:card_combination)->Bool{
    
    let pCardType=previousCard.combination_number//牌型
    let cCardType=currentCard.combination_number
    var previous=[card](repeating:tempCard,count:previousCard.amount)//上个玩家牌数组，做后面的e操作
    var current=[card](repeating:tempCard,count:currentCard.amount)//自己牌数组
    for (index,item) in previousCard.cards.enumerated(){//牌数组赋值
        previous[index]=item
    }
    for (index,item) in currentCard.cards.enumerated(){
        current[index]=item
    }
    if !(previousCard.amount==currentCard.amount) {return false}//牌个数不等
    if (!(pCardType==cCardType))&&(pCardType>2)&&(cCardType>2) {return pCardType>cCardType}//牌数相同，都是五张，但牌型不同药比较
    previous.sort(by: {(A:card,B:card)->Bool in return A.number>B.number})//牌大小排序
    current.sort(by: {(A:card,B:card)->Bool in return A.number>B.number})
    if (previousCard.amount==5){
        if (!(previous[1].number==previous[2].number+1))&&(pCardType==3||pCardType==7){//A2345这种特殊情况，按number排序后是2A543，A的number和5相差很大
            previous[0].number=1
            previous[1].number=2
            previous.sort(by: {(A:card,B:card)->Bool in return A.number>B.number})
        }
        if (!(previous[0].number==previous[1].number+1))&&(pCardType==3||pCardType==7){//23456这种特殊情况，按number排序后是26543，2的number和6相差很大
            previous[0].number=2
            previous.sort(by: {(A:card,B:card)->Bool in return A.number>B.number})
        }
    }
    if(currentCard.amount==5){
        if (!(current[1].number==current[2].number+1))&&(cCardType==3||cCardType==7){
            current[0].number=1
            current[1].number=2
            current.sort(by: {(A:card,B:card)->Bool in return A.number>B.number})
        }
        if (!(current[0].number==current[1].number+1))&&(pCardType==3||pCardType==7){//23456这种特殊情况，按number排序后是26543，2的number和6相差很大
            current[0].number=2
            current.sort(by: {(A:card,B:card)->Bool in return A.number>B.number})
        }
    }
    if previousCard.combination_number==currentCard.combination_number {//同类型比较
        switch pCardType{
        case 0://单张
            if previous[0].number<current[0].number {return true}
            else if previous[0].number==current[0].number{
                return previous[0].color<current[0].color
            }
            else {return false}
        case 1://一对
            if previous[0].number<current[0].number {return true}
            else if previous[0].number==current[0].number{
                //previousCard.sort(by: {(A:card,B:card)->Bool in return A.color>B.color})
                //currentCard.sort(by: {(A:card,B:card)->Bool in return A.color>B.color})
                if previous[0].color<current[0].color {return true}
                else if previous[0].color==current[0].color
                {return previous[1].color<current[1].color }
                else {return false}
            }
            else {return false}
        case 2://三张
            if previous[0].number<current[0].number {return true}
            else if previous[0].number==current[0].number{
                
                if previous[0].color<current[0].color {return true}
                else if previous[0].color==current[0].color
                {
                    if previous[1].color<current[1].color {return true}
                    else if previous[1].color==current[1].color {return previous[2].color<current[2].color}
                    else {return false}
                }
                else {return false}
            }
            else {return false}
        case 3://杂顺
            
            let temp=flagNumber(A: previous, B: current,N:previousCard.amount)
            if(temp>=0&&temp<previousCard.amount) {return true}
            else{
                return JudgeColor(count:temp,A:previous,B:current)}
        case 7://同花顺
            let temp=flagNumber(A: previous, B: current,N:previousCard.amount)
            if(temp>=0&&temp<previousCard.amount) {return true}
            else{
                return JudgeColor(count:temp,A:previous,B:current)}
        case 4://同花五
            let temp=flagNumber(A: previous, B: current,N:previousCard.amount)
            if(temp>=0&&temp<previousCard.amount) {return true}
            else{
                return JudgeColor(count:temp,A:previous,B:current)}
        case 5://三带一对
            var preTriple:Int
            var prePair:Int
            var curTriple:Int
            var curPair:Int
            var pTripleColor:Int
            var pPairColor:Int
            var cTripleColor:Int
            var cPairColor:Int
            if previous[0].number==previous[2].number//已排序，xxxyy格式
            {
                preTriple=previous[0].number//三只相同的牌的数
                prePair=previous[3].number
                pTripleColor=previous[0].color+previous[1].color+previous[2].color
                pPairColor=previous[3].color+previous[4].color
            }
            else
            {
                preTriple=previous[2].number//三只相同的牌的数
                prePair=previous[0].number
                pTripleColor=previous[2].color+previous[3].color+previous[4].color
                pPairColor=previous[0].color+previous[1].color
            }
            if current[0].number==current[2].number//已排序，xxxyy格式
            {
                curTriple=current[0].number//三只相同的牌的数
                curPair=current[3].number
                cTripleColor=current[0].color+current[1].color+current[2].color
                cPairColor=current[3].color+current[4].color
            }
            else
            {
                curTriple=current[2].number//三只相同的牌的数
                curPair=current[0].number
                cTripleColor=current[2].color+current[3].color+current[4].color
                cPairColor=current[0].color+current[1].color
            }
            if !(preTriple==curTriple) {return preTriple>curTriple}
            else if !(prePair==curPair) {return prePair>prePair}
            else if pTripleColor>cTripleColor {return true}
            else {return pPairColor>cPairColor}
        case 6://四代一张
            var preQuatary:Int
            var preSingle:Int
            var curQuatary:Int
            var curSingle:Int
            var pQuataryColor:Int
            var pSingleColor:Int
            var cQuataryColor:Int
            var cSingleColor:Int
            if previous[0].number==previous[3].number//已排序，xxxxy格式
            {
                preQuatary=previous[0].number//四只相同的牌的数
                preSingle=previous[4].number
                pQuataryColor=previous[0].color+previous[1].color+previous[2].color+previous[3].color
                pSingleColor=previous[4].color
            }
            else
            {
                preQuatary=previous[1].number//四只相同的牌的数
                preSingle=previous[0].number
                pQuataryColor=previous[1].color+previous[2].color+previous[3].color+previous[4].color
                pSingleColor=previous[0].color
            }
            if current[0].number==current[3].number//已排序，xxxxy格式
            {
                curQuatary=current[0].number//四只相同的牌的数
                curSingle=current[4].number
                cQuataryColor=current[0].color+current[1].color+current[2].color+current[3].color
                cSingleColor=current[4].color
            }
            else
            {
                curQuatary=current[1].number//四只相同的牌的数
                curSingle=current[0].number
                cQuataryColor=current[1].color+current[2].color+current[3].color+current[4].color
                cSingleColor=current[0].color
            }
            if !(preQuatary==curQuatary) {return preQuatary>curQuatary}
            else if !(preSingle==curSingle) {return preSingle>preSingle}
            else if pQuataryColor>cQuataryColor {return true}
            else {return pSingleColor>cSingleColor}
        case 8://错误牌型
            return false
        default:
            return false
        }
    }
    return false
}

/*****************************************************/
//发牌函数
func randomCard()->[[card]]{
    let card1 = card(color: 0, number: 0)
    var totCard = [card](repeating: card1, count: 52)
    var count = 0
    for i in 0...3{
        for j in 3...15{
            totCard[count].color = i;
            totCard[count].number = j;
            count=count+1
        }
    }
    for i in 1...totCard.count{
        let index = Int(arc4random())%i;
        totCard.swapAt(i-1, index)
    }
    var cards1 = [card](repeating: card1, count: 13)
    var cards2 = [card](repeating: card1, count: 13)
    var cards3 = [card](repeating: card1, count: 13)
    var cards4 = [card](repeating: card1, count: 13)
    
    for i in 0...12{
        cards1[i]=totCard[i]
        cards2[i]=totCard[i+13]
        cards3[i]=totCard[i+26]
        cards4[i]=totCard[i+39]
    }
    let fourCards : [[card]]=[cards1, cards2, cards3, cards4]
    return fourCards
}

//有上家出牌
func showingCard(previousCard: card_combination ,playerCard: inout [card], showCard: card_combination, validateCard: inout card_combination) ->Bool{
    print("previous:")
    print(previousCard)
    print("show:")
    print(showCard)
    let validate = checkCard(previousCard: previousCard, showCard: showCard)   //如果出牌不符合规则返回0
    if !validate {
        print("fause!")
        return false
    } else {
        substractCard(currentCards: &playerCard, showCards: showCard.cards) //如果出牌符合规则，玩家的牌减少
        validateCard = showCard
        return true   //返回1
    }
}
//无上家出牌
func showingCard(playerCard: inout [card], showCard: card_combination, validateCard: inout card_combination) ->Bool{
    let validate = checkCard(showCard : showCard)   //如果出牌不符合规则返回0
    if !validate {
        return false
    } else {
        print("!!!!!!show")
        substractCard(currentCards: &playerCard, showCards: showCard.cards) //如果出牌符合规则，玩家的牌减少
        validateCard = showCard
        return true   //返回1
    }
}

//有上家检测牌是否有效
func checkCard(previousCard: card_combination, showCard: card_combination) ->Bool{
    if previousCard.combination_number==showCard.combination_number{
        print("previouscheck")
        print(previousCard)
        print("currentcard")
        print(showCard)
        if IsBigger(previousCard: previousCard, currentCard: showCard){
            return true
        } else{
            return false
        }
    }else{
        return false
    }
}

//无上家检测牌是否有效
func checkCard(showCard: card_combination) ->Bool{
    if showCard.combination_number == 8{//如果不符合牌型，返回false，出牌失败
        return false
    } else {//如果符合牌型，返回true，出牌成功
        return true
    }
}
//从玩家数组里减去出过的牌
func substractCard(currentCards:inout [card], showCards: [card]){
    print(currentCards)
    print(showCards)
    if showCards.count>0{
    for i in 0...showCards.count-1{
        for j in 0...currentCards.count-1{
            if currentCards[j].number==showCards[i].number && currentCards[j].color==showCards[i].color{
                currentCards[j].number = 99
                currentCards[j].color = 99//出过的牌number为-1
                break
            }
        }
    }
    }
}
//判断玩家的牌是否出完，参数为cards，储存card,默认牌有13张，出完牌则为空
func nullCard(cards: [card]) -> Bool{
    if cards.isEmpty{
        return true
    }else{
        return false
    }
}
//players是一个数组，储存四个player结构体
func rankMark(players: inout [player]){
    var mark : [Int] = [players[0].mark, players[1].mark, players[2].mark, players[3].mark]
    var mark1=mark.sorted()
    for i in 0...mark1.count-1{
        let x=i+1
        for j in 0...mark.count-1{
            if mark[j]==mark1[i]{
                players[j].rank=x
            }
        }
    }
}
//定位方块3的位置，返回的是玩家的下标，0，1，2，3
func identifyBlock3(players : [player]) ->Int{
    for index in 0...players.count-1{
        if haveBlock3(cards : players[index].myCards){
            return index
        }
    }
    return -1
}
func haveBlock3(cards : [card]) ->Bool{
    var count = 0
    for index in 0...cards.count-1{
        if(cards[index].color==0 && cards[index].number == 3){
            count = count+1
        }
    }
    if count==0{
        return false
    }else{
        return true
    }
}
//储存牌的数组转化为字符流，通过蓝牙传输到中心设备
func string_to_card(card_name: String) -> card {
    if card_name[card_name.startIndex] == "1" {
        let color1 = Int(card_name.substring(from: card_name.index(card_name.startIndex, offsetBy: 2)))
        let number1 = Int(card_name.substring(to: card_name.index(card_name.startIndex, offsetBy: 2)))
        let card1 = card(color: color1!, number: number1!)
        return card1
    }
        
    else {
        let color1 = Int(card_name.substring(from: card_name.index(card_name.startIndex, offsetBy: 1)))
        let number1 = Int(card_name.substring(to: card_name.index(card_name.startIndex, offsetBy: 1)))
        let card1 = card(color: color1!, number: number1!)
        return card1
    }
}
//从names数组转化为[[card]]
func strings_to_cards(card_names: [String]) -> [card] {
    var cards1: [card] = []
    if card_names.count>0{
    for i in 0...card_names.count-1 {
        cards1.append(string_to_card(card_name: card_names[i]))
    }
    }
    return cards1
}
/*
func initPlayer()->[player]{
    var players:[player] = []
    let initCard = randomCard()
    let player1 = player(id : 1, name : "player1", mark : 0, rank : 0, state : false, myCards :initCard[0], myShowcards : defaultShow)
    let player2 = player(id : 2, name : "player2", mark : 0, rank : 0, state : false, myCards :initCard[1], myShowcards : defaultShow)
    let player3 = player(id : 3, name : "player3", mark : 0, rank : 0, state : false, myCards :initCard[2], myShowcards : defaultShow)
    let player4 = player(id : 4, name : "player4", mark : 0, rank : 0, state : false, myCards :initCard[3], myShowcards : defaultShow)
    players = [player1, player2, player3, player4]
    return players
}


 */

//将以选择的牌名字删除
func remove(names : inout [String], tag : String){
    var j = 0
    if !names.isEmpty{
        for i in names{
            if i==tag{
                names.remove(at: j)
            }
            j = j+1
        }
    }
}
//数组操作，点击牌，增加或者减少数组里牌的名字

























