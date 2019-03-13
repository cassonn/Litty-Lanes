//
//  CGame.swift
//  Squeeze1
//
//  Created by Nic Casson on 2017-12-02.
//  Copyright © 2017 CassonApps. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameplayKit

class Game : SKScene, SKPhysicsContactDelegate {
    
    var enemyR = SKSpriteNode(imageNamed: "ER.png")
    var enemyY = SKSpriteNode(imageNamed: "EY.png")
    var enemyG = SKSpriteNode(imageNamed: "EG.png")
    var enemyB = SKSpriteNode(imageNamed: "EB.png")
    var enemyP = SKSpriteNode(imageNamed: "EP.png")
    var user = SKSpriteNode(imageNamed: "RuserImageC.png")   //Initializes the userImage
    var diamond = SKSpriteNode(imageNamed: "diamondM.png")
    var posAssignCounter = 0
    var moveCharL = Bool()
    var moveCharR = Bool()
    var shade = SKSpriteNode()
    var pa = SKLabelNode()
    var y = SKLabelNode()
    var n = SKLabelNode()
    
    public struct Queue{
        var Q = LinkedList()
        
        init() {
            
        }
        func enter(newCall: Array<String>) {
            Q.moveIn(newList: newCall)
        }
        func leave() -> Array<String> {
            return Q.moveOut()
        }
        func printQ() {
            print(Q.printList())
        }
    }
    
    var listOfEnemyList = Queue()
    
    var startY_Hold = CGFloat()
    var endY_Hold = CGFloat()
    
    var userPhysicsBodyImage = String()
    
    var userChangeX = CGFloat(0.0)
    var op = CGFloat(0.0)
    var ad = CGFloat(0.0)
    var hy = CGFloat(0.0)
    var ratio = CGFloat(0.0)
    var anchorPos = CGPoint(x: 0.0, y: 0.0)
    var vehicleAngle = CGFloat(0.0)
    
    var quad1 = Bool()
    var quad2 = Bool()
    var quad3 = Bool()
    var quad4 = Bool()
    
    //PRESET IMAGEs

    var playerScore = 0
    var scoreLabel = SKLabelNode()
    var diamondLabel = SKLabelNode()
    var diamondC = SKSpriteNode()
    
    var colourNamesNext = Array<String>()
    var colourNamesCurrent = Array<String>()
    var userVOptions = Array<String>()
    var userVOptionsReduced = Array<String>()
    var userVOptionsNoDuplicates = Array<String>()
    var arraySize = Int()
    
    var setUserBool = true
    
    func randInt1a() -> Int {
        return Int(arc4random_uniform(UInt32(5)))
    }
    func randInt1b() -> Int {
        return Int(arc4random_uniform(UInt32(5)))
    }
    func randInt2a() -> Int {
        return Int(arc4random_uniform(UInt32(4)))
    }
    func randInt2b() -> Int {
        return Int(arc4random_uniform(UInt32(4)))
    }
    func randInt3a() -> Int {
        return Int(arc4random_uniform(UInt32(3)))
    }
    func randInt3b() -> Int {
        return Int(arc4random_uniform(UInt32(3)))
    }
    func randInt4a() -> Int {
        return Int(arc4random_uniform(UInt32(2)))
    }
    func randInt4b() -> Int {
        return Int(arc4random_uniform(UInt32(2)))
    }
    func randIntEnemy() -> Int {
        return Int(1 + arc4random_uniform(UInt32(10)))
    }
    func randIntDiamonds() -> Int {
        return Int(1 + arc4random_uniform(UInt32(5)))
    }
    func genRandUserImage(randRange : Int) -> Int {
        return Int(arc4random_uniform(UInt32(randRange)))
    }
    
    struct physicsBodies {
        static var contactAll:UInt32 = 0b0
        static var enemyContact:UInt32 = 0b1
        static var userContact:UInt32 = 0b10
        static var diamondContact:UInt32 = 0b100
    }
    
    func spawnEnemy1() -> (Array<CGFloat>,Array<String>) {
        self.colourNamesNext = []
        posAssignCounter = 1
        let randNumName = randInt1a()
        let randNumPos = randInt1b()
        let randIntEn = randIntEnemy()
        let randIntEnLabel = SKLabelNode(text: "\(randIntEn)")
        randIntEnLabel.fontSize = 18.0
        randIntEnLabel.fontColor = UIColor.black
        var enemyArray = Array(["ER.png","EY.png","EG.png","EB.png","EP.png"])
        let imageName = enemyArray[randNumName]
        let enemy1 = SKSpriteNode(imageNamed: imageName)
        enemy1.setScale(1/5.8)
        var modArray = Array([CGFloat(0.0),CGFloat(0.0 - enemyG.size.width - enemyG.size.width/20),CGFloat(0.0 - enemyG.size.width*2 - enemyG.size.width/10),CGFloat(0.0 + enemyG.size.width + enemyG.size.width/20),CGFloat(0.0 + enemyG.size.width*2 + enemyG.size.width/10)])
        let enemy = enemy1
        let enemyName = imageName.appending("\(randIntEn)")
        colourNamesNext.append(enemyName)
        enemy.name = enemyName                                               //Appends enemy value
        let startX = modArray[randNumPos]
        let endX = startX
        let startY = CGFloat(self.size.height + enemy1.size.height)
        let endY = CGFloat(0 - self.size.height/5 + enemy.size.height/2 - 1)
        let startPoint = CGPoint(x: startX, y: startY)
        let endPoint = CGPoint(x: endX, y: endY)
        randIntEnLabel.position = startPoint
        randIntEnLabel.zPosition = 6
        self.addChild(randIntEnLabel)
        enemy.position = startPoint
        enemy.zPosition = 2
        let enemyTexture = SKTexture(imageNamed: "EB")
        let enemySize = CGSize(width: enemy.size.width, height: enemy.size.height)
        enemy.physicsBody = SKPhysicsBody(texture: enemyTexture , size: enemySize)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.collisionBitMask = UInt32(physicsBodies.contactAll)
        enemy.physicsBody?.categoryBitMask = UInt32(physicsBodies.enemyContact)
        enemy.physicsBody?.contactTestBitMask = UInt32(physicsBodies.userContact)
        self.addChild(enemy)
        let moveEnemy = SKAction.move(to: endPoint, duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy])
        enemy.run(enemySequence)
        randIntEnLabel.run(enemySequence)
        modArray.remove(at: randNumPos)
        enemyArray.remove(at: randNumName)
        return (modArray,enemyArray)
    }

    func spawnEnemy27(modedArray : Array<CGFloat>,randIntPos : Int,randIntName : Int ,enemyArrayN : Array<String>) -> (Array<CGFloat>,Array<String>) {
        posAssignCounter += 1
        let randIntEn = randIntEnemy()
        let randIntEnLabel = SKLabelNode(text: "\(randIntEn)")
        randIntEnLabel.fontSize = 18.0
        randIntEnLabel.fontColor = UIColor.black
        let randNumName = randIntName
        let randNumPos = randIntPos
        var modArray = modedArray
        var enemyArray = enemyArrayN
        let randEnemy = enemyArray[randNumName]
        let enemy = SKSpriteNode(imageNamed: randEnemy)
        enemy.setScale(1/5.8)
        let enemyName = randEnemy.appending("\(randIntEn)")
        colourNamesNext.append(enemyName)
        enemy.name = enemyName                                      //Appends enemy name with value
        let startX = modArray[randNumPos]
        let endX = startX
        let startY = CGFloat(self.size.height + enemy.size.height)
        startY_Hold = startY
        let endY = CGFloat(0 - self.size.height/5 + enemy.size.height/2 - 1)
        endY_Hold = endY
        let startPoint = CGPoint(x: startX, y: startY)
        let endPoint = CGPoint(x: endX, y: endY)
        randIntEnLabel.position = startPoint
        randIntEnLabel.zPosition = 6
        self.addChild(randIntEnLabel)
        enemy.position = startPoint
        enemy.zPosition = 2
        let enemyTexture = SKTexture(imageNamed: "EB")
        let enemySize = CGSize(width: enemy.size.width, height: enemy.size.height)
        enemy.physicsBody = SKPhysicsBody(texture: enemyTexture , size: enemySize)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.collisionBitMask = UInt32(physicsBodies.contactAll)
        enemy.physicsBody?.categoryBitMask = UInt32(physicsBodies.enemyContact)
        enemy.physicsBody?.contactTestBitMask = UInt32(physicsBodies.userContact)
        self.addChild(enemy)
        let moveEnemy = SKAction.move(to: endPoint, duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy])
        enemy.run(enemySequence)
        randIntEnLabel.run(enemySequence)
        modArray.remove(at: randNumPos)
        enemyArray.remove(at: randNumName)
        
        return (modArray,enemyArray)
    }
    
    func spawnDiamonds() {
        let diamondCash = SKSpriteNode(imageNamed: "diamondM.png")
        let randDiamondInt = randIntDiamonds()
        let randDiamondLabel = SKLabelNode(text: "\(randDiamondInt)")
        let diamondSpawnScale = SKSpriteNode(imageNamed: "ER.png")
        diamondSpawnScale.setScale(1/5.8)
        randDiamondLabel.fontSize = 12
        randDiamondLabel.fontColor = UIColor.black
        enemyG.setScale(1/5.8)
        diamondCash.setScale(1/5.8)
        let randInt = randInt1a()
        var posArray = Array([CGFloat(0.0),CGFloat(0.0 - enemyG.size.width - enemyG.size.width/50),CGFloat(0.0 - enemyG.size.width*2 - enemyG.size.width/50),CGFloat(0.0 + enemyG.size.width + enemyG.size.width/50),CGFloat(0.0 + enemyG.size.width*2 + enemyG.size.width/50)])
        let startingY = self.size.height*1.5
        let startingX = posArray[randInt]
        let endingX = startingX
        let endingY = self.size.height * -1.5
        let startingPoint = CGPoint(x: startingX, y: startingY)
        let endingPoint = CGPoint(x: endingX, y: endingY)
        let diamondName = "diamond"
        diamondCash.name = diamondName.appending("\(randDiamondInt)") //Appends diamond value ex. "diamond7"
        diamondCash.position = startingPoint
        diamondCash.zPosition = 5
        diamondCash.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: diamondCash.size.width, height: diamondCash.size.height))
        diamondCash.physicsBody?.affectedByGravity = false
        diamondCash.physicsBody?.collisionBitMask = UInt32(physicsBodies.contactAll)
        diamondCash.physicsBody?.categoryBitMask = UInt32(physicsBodies.diamondContact)
        diamondCash.physicsBody?.contactTestBitMask = UInt32(physicsBodies.userContact)
        randDiamondLabel.position = startingPoint
        randDiamondLabel.zPosition = 6
        diamondCash.addChild(randDiamondLabel)
        self.addChild(diamondCash)
        let moveDiamond = SKAction.move(to: endingPoint, duration: 7.5)
        let deleteDiamond = SKAction.removeFromParent()
        let diamondSequence = SKAction.sequence([moveDiamond,deleteDiamond])
        randDiamondLabel.run(diamondSequence)
        diamondCash.run(diamondSequence)
    }
    
    func spawning(birth:Array<SKAction>) {
        
        for action in birth{
            let wait = SKAction.wait(forDuration: 1.4)
            let birthSequence = SKAction.sequence([action,wait])
            let birthForever = SKAction.repeatForever(birthSequence)
            self.run(birthForever)
        }
    }
    
    func spawningD(birthD:SKAction) {
        
        let wait = SKAction.wait(forDuration: 1.4)
        let birthSequence = SKAction.sequence([birthD,wait])
        let birthForever = SKAction.repeatForever(birthSequence)
        self.run(birthForever)
    }
    
    func makeRoad() { //Adds road image as child
        for ii in 0...3 {
            let backGround = SKSpriteNode(imageNamed: "backGround.png")
            backGround.name = "backGround"
            backGround.size = CGSize(width: self.size.width, height: self.size.height)
            backGround.position = CGPoint(x: 0.0, y: CGFloat(ii)*backGround.size.height)
            self.addChild(backGround)
        }
    }
    
    func moveRoad() {  //Moves road in loop
        self.enumerateChildNodes(withName: "backGround", using: ({
            (node,error) in
            node.position.y -= 4
            if node.position.y < -(self.size.height) {
                node.position.y += self.size.height*3
            }
        }))
    }
    
    override func sceneDidLoad() {  //LOAD SCENE -------------------------------------------------------------------------------------------------
        
        self.physicsWorld.contactDelegate = self
        
        shade = self.childNode(withName: "shade") as! SKSpriteNode
        shade.isHidden = true
        pa = self.childNode(withName: "pa") as! SKLabelNode
        pa.isHidden = true
        y = self.childNode(withName: "y") as! SKLabelNode
        y.isHidden = true
        n = self.childNode(withName: "n") as! SKLabelNode
        n.isHidden = true
        
        moveCharL = false
        moveCharR = false
        
        var diamondCount = Menu.glbls.diamondCount
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        diamondC = self.childNode(withName: "diamondC") as! SKSpriteNode
        diamondLabel = self.childNode(withName: "diamondLabel") as! SKLabelNode
        scoreLabel.text = "\(playerScore)"
        diamondLabel.text = "\(UserDefaults.standard.integer(forKey: "bankAccount"))"
        diamondC.texture = SKTexture(imageNamed: "diamondM")
        
        UserDefaults.standard.set("Cuser", forKey: "userPlayer") //Temporary user string*********************
        
        enemyG.setScale(1/5.8)
        var modArray = Array([CGFloat(0.0),CGFloat(0.0 - enemyG.size.width - enemyG.size.width/30),CGFloat(0.0 - enemyG.size.width*2 - enemyG.size.width/30),CGFloat(0.0 + enemyG.size.width + enemyG.size.width/30),CGFloat(0.0 + enemyG.size.width*2 + enemyG.size.width/30)])
        var enemyArray = ["ER.png","EY.png","EG.png","EB.png","EP.png"]
        var storeCount = [0,1,2,3,4,5,6]
        
        var spawn1Tuple = (Array<CGFloat>(),Array<String>())
        var spawn1ModArray = Array<CGFloat>()
        var spawn1EnemyArray = Array<String>()
        var spawn2Tuple = (Array<CGFloat>(),Array<String>())
        var spawn2ModArray = Array<CGFloat>()
        var spawn2EnemyArray = Array<String>()
        var spawn3Tuple = (Array<CGFloat>(),Array<String>())
        var spawn3ModArray = Array<CGFloat>()
        var spawn3EnemyArray = Array<String>()
        var spawn4Tuple = (Array<CGFloat>(),Array<String>())
        var spawn4ModArray = Array<CGFloat>()
        var spawn4EnemyArray = Array<String>()
        
        var spawnSequenceActions = Array<SKAction>()
        
        let spawn1 = SKAction.run {
            spawn1Tuple = self.spawnEnemy1()
            spawn1ModArray = spawn1Tuple.0
            spawn1EnemyArray = spawn1Tuple.1 // modified name list
        }
        spawnSequenceActions.append(spawn1)
        
        let spawn2 = SKAction.run {
            spawn2Tuple = self.spawnEnemy27(modedArray: spawn1ModArray, randIntPos: self.randInt2a(), randIntName: self.randInt1b(), enemyArrayN: enemyArray)
            spawn2ModArray = spawn2Tuple.0
            spawn2EnemyArray = spawn2Tuple.1
        }
        spawnSequenceActions.append(spawn2)
        
        let spawn3 = SKAction.run {
            spawn3Tuple = self.spawnEnemy27(modedArray: spawn2ModArray, randIntPos: self.randInt3a(), randIntName: self.randInt1b(), enemyArrayN: enemyArray)
            spawn3ModArray = spawn3Tuple.0
            spawn3EnemyArray = spawn3Tuple.1
        }
        spawnSequenceActions.append(spawn3)
        
        let spawn4 = SKAction.run {
            spawn4Tuple = self.spawnEnemy27(modedArray: spawn3ModArray, randIntPos: self.randInt4a(), randIntName: self.randInt1b(), enemyArrayN: enemyArray)
            spawn4ModArray = spawn4Tuple.0
            spawn4EnemyArray = spawn4Tuple.1
        }
        spawnSequenceActions.append(spawn4)
        
        let spawn5 = SKAction.run {
            self.spawnEnemy27(modedArray: spawn4ModArray, randIntPos: 0, randIntName: self.randInt1b(), enemyArrayN: enemyArray)
            
            self.colourNamesCurrent = self.colourNamesNext
            self.listOfEnemyList.enter(newCall: self.colourNamesCurrent)
            let userTextureArraySet = self.vehicleChoices(currentEnemyNames: self.colourNamesCurrent).0
            let userTextureIntSet = self.genRandUserImage(randRange: self.vehicleChoices(currentEnemyNames: self.colourNamesCurrent).1)
            let randTextureNum = Int(arc4random_uniform(UInt32(userTextureIntSet)))
            
            if self.setUserBool {
                self.user.texture = SKTexture(imageNamed: userTextureArraySet[randTextureNum])
                self.user.name = userTextureArraySet[randTextureNum]
                self.listOfEnemyList.leave()
                self.setUserBool = false
            }
        }
        spawnSequenceActions.append(spawn5)
        
        let spawnDiamonds1 = SKAction.run {
            self.spawnDiamonds()
        }
        self.spawningD(birthD: spawnDiamonds1)

        var userTexture = SKTexture(imageNamed: userPhysicsBodyImage)
        let userSize = CGSize(width: self.user.size.width, height: self.user.size.height)
        self.user.physicsBody = SKPhysicsBody(texture: userTexture , size: userSize)
        self.user.physicsBody?.affectedByGravity = false
        self.user.physicsBody?.collisionBitMask = physicsBodies.contactAll
        self.user.physicsBody?.categoryBitMask = physicsBodies.userContact
        self.user.physicsBody?.contactTestBitMask = physicsBodies.enemyContact | physicsBodies.diamondContact
        self.addChild(self.user)
        user.setScale(1/7)
        user.position = CGPoint(x: 0, y: 0 - self.size.height/5)
        user.zPosition = 7
        
        makeRoad()
        
        self.spawning(birth: spawnSequenceActions)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //TOUCHES ---------------------------------------------------------------
        
        anchorPos = CGPoint(x:0.0, y: -(self.size.height/2))
        
        for touch in touches {
            let touchPoint = touch.location(in: self)
            
            if ((touch.location(in: self).x < 0)){
                if (user.position.x > ((-1)*((self.size.width/2) - self.size.width/5))) {
                    user.position.x -= (self.size.width)/5
                }
            }
            if ((touch.location(in: self).x >= 0)){
                if (user.position.x < ((self.size.width/2) - self.size.width/5)) {
                   user.position.x += (self.size.width)/5
                }
            }
            
            if(isDead()){
                if(atPoint(touchPoint).name == "y"){
                    if let view = self.view {
                        let scene = Game(fileNamed: "GameScene")
                        // Set the scale mode to scale to fit the window
                        scene?.scaleMode = .aspectFill
                        // Present the scene
                        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 2))
                    }
                }
                if(atPoint(touchPoint).name == "n"){
                    if let view = self.view {
                        let scene = Menu(fileNamed: "MenuScene")
                        // Set the scale mode to scale to fit the window
                        scene?.scaleMode = .aspectFill
                        // Present the scene
                        view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 2))
                    }
                }
            }
            
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        moveRoad()
        
    }
   
    
    func vehicleChoices(currentEnemyNames : Array<String>) -> (Array<String>,Int) {
        
        userVOptions = []
        userVOptionsReduced = []
        userVOptionsNoDuplicates = []
        
        let userNodeString = Menu.glbls.userPlayer   // will be saved in notation: "Cuser"
        let startIndex = userNodeString?.startIndex
        let index = userNodeString?.index(startIndex!, offsetBy: 1)
        let searchFor = userNodeString?.substring(to: index!) //Identifies user vehicle: "C"
        for option in Menu.glbls.userImages { //Option is
            let startIndexOption = option.startIndex
            let index1 = option.index(startIndexOption, offsetBy: 10)
            let optionName = option.substring(from: index1)
            //For each vehicle in possible vehicles finds if it matches the player vehicle
            if optionName.hasPrefix(searchFor!) {
                userVOptions.append(option)
                //userVOpotions is array of all vehicle options in notation: "RuserImageC.png"
            }
        }
    
        ////----check user vehicles array against enemyNames array and generate new array of possible vehicle colors
        for enemy in currentEnemyNames {
            let startIndexEnemy = enemy.startIndex
            let indexEnemy = enemy.index(startIndexEnemy, offsetBy: 1)
            let enemyColour = enemy.substring(from: indexEnemy)
            let startIndexEnemy1 = enemyColour.startIndex
            let indexEnemy1 = enemyColour.index(startIndexEnemy1, offsetBy: 1)
            let enemyColour2 = enemyColour.substring(to: indexEnemy1)   //colour of enemy in form ("B","Y",ect.)
            for rOption in Menu.glbls.userImages {
                if rOption.hasPrefix(enemyColour2) {
                    userVOptionsReduced.append(rOption)
                }
            }
        }
        //--------------Remove duplicates from userVOptionsReduced, notation: ["RuserImageC.png","BuserImageC.png"]
        for finalOption in userVOptionsReduced {
            if userVOptionsNoDuplicates.contains(finalOption) == false {
                userVOptionsNoDuplicates.append(finalOption)
            }
        }
        arraySize = userVOptionsNoDuplicates.count
        
        return (userVOptionsNoDuplicates,arraySize)
    }
    
    private func setUserTexture(){
        //print(listOfEnemyList.printQ())
        let nextInQ = listOfEnemyList.leave()
        print(nextInQ)
        let set = self.vehicleChoices(currentEnemyNames: nextInQ)
        let userTextureArraySet = set.0
        let userTextureIntSet = self.genRandUserImage(randRange: set.1)
        self.user.texture = SKTexture(imageNamed: userTextureArraySet[userTextureIntSet])
        self.user.name = userTextureArraySet[userTextureIntSet]
    }
    
    func didBegin(_ contact: SKPhysicsContact) {  //PHYSICS CONTACT -------------------------------------------------------------------------------------
        if ((contact.bodyA.node != nil) && (contact.bodyB.node != nil)) {
            let bod1 = contact.bodyA.node!
            let bod2 = contact.bodyB.node!
            
            if ((bod1.name?.hasPrefix("E"))! && (bod2.name?.hasSuffix("g"))!) {      //If enemy and user contact.....................
                let enemyColorID = enemySubstringer(enemy: bod1)
                
                if ((bod2.name?.hasPrefix(enemyColorID))! && (bod1 != nil)) { //If they are same color
                    playerScore = Int(scoreLabel.text!)! + pointAdder(enemy: bod1)
                    scoreLabel.text = String(playerScore)
                    if(playerScore > UserDefaults.standard.integer(forKey: "highScore")){
                        UserDefaults.standard.set(playerScore, forKey: "highScore")
                    }
                    addExplosion(name: "explosion", yPos: (user.position.y + user.size.height/2), endsGame: false)
                    bod1.removeFromParent()
                    setUserTexture()
                }
                else { //If they are not the same color
                    addExplosion(name: "carExplosion", yPos: user.position.y, endsGame: true)
                    death()
                }
            }
            
            else if ((bod2.name?.hasPrefix("E"))! && (bod1.name?.hasSuffix("g"))!) {
               
                let enemyColorID = enemySubstringer(enemy: bod2)
                
                if ((bod1.name?.hasPrefix(enemyColorID))! && (bod2 != nil)) {
                    playerScore = Int(scoreLabel.text!)! + pointAdder(enemy: bod2)
                    scoreLabel.text = String(playerScore)
                    if(playerScore > UserDefaults.standard.integer(forKey: "highScore")){
                        UserDefaults.standard.set(playerScore, forKey: "highScore")
                    }
                    addExplosion(name: "explosion", yPos: (user.position.y + user.size.height/2), endsGame: false)
                    bod2.removeFromParent()
                    setUserTexture()
                }
                else {
                    addExplosion(name: "carExplosion", yPos: user.position.y, endsGame: true)
                    death()
                }
            }
            
            if ((bod1.name?.hasPrefix("diamond"))!&&(bod2.name?.hasSuffix("g"))!) {  //If diamond and user contact......................
                diamondColletion(diamond: bod1)
            }
            
            else if ((bod2.name?.hasPrefix("diamond"))!&&(bod1.name?.hasSuffix("g"))!) {
                diamondColletion(diamond: bod2)
            }
            
        }

    }
    
    func enemySubstringer(enemy: SKNode) -> String {  //Converts png file to first leter of enemy color and returns that string
        let startIndex = enemy.name?.startIndex
        let indexNum = enemy.name?.index(startIndex!, offsetBy: 1)
        let enemyColour = enemy.name?.substring(from: indexNum!) //Enemy colour "B.pngx","R.pngx"...ect
        let startIndexEnemy = enemyColour?.startIndex
        let indexEnemy = enemyColour?.index(startIndexEnemy!, offsetBy: 1)
        let enemyColour2 = enemyColour?.substring(to: indexEnemy!) //Enemy colour "B","R"...ect
        return enemyColour2!
    }
    
    func diamondColletion(diamond: SKNode) {  //Deletes diamond and label node adding and saving the worth to the player bank
        let startIndex = diamond.name?.startIndex
        let indexNum = diamond.name?.index(startIndex!, offsetBy: 7)
        let value = diamond.name?.substring(from: indexNum!) //Should grab value appended to name ex. diamond'7'
        var diamond_Worth = Int(value!)
        diamond.removeAllChildren()
        diamond.removeFromParent()
        
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "bankAccount") + diamond_Worth!, forKey: "bankAccount")
        diamondLabel.text = String(UserDefaults.standard.integer(forKey: "bankAccount"))
    }
    
    func pointAdder(enemy: SKNode) -> Int{
        let startIndex = enemy.name?.startIndex
        let indexNum = enemy.name?.index(startIndex!, offsetBy: 6)
        let enemyValue = enemy.name?.substring(from: indexNum!) //Should grab value appended to name ex. EB.png'3'
        return Int(enemyValue!)!
    }
    
    func addExplosion(name:String, yPos: CGFloat, endsGame: Bool) {  //Creates explosion with a given emmiter node
        let explodePath = Bundle.main.path(forResource: name, ofType: "sks")
        let node = NSKeyedUnarchiver.unarchiveObject(withFile: explodePath!) as! SKEmitterNode
        
        node.position = CGPoint(x: user.position.x, y: yPos)
        node.zPosition = 5
        node.targetNode = self
        
        self.addChild(node)
        let run = SKAction.wait(forDuration: 0.25)
        let run2 = SKAction.removeFromParent()
        node.run(SKAction.sequence([run,run2]))
        
        if endsGame {
            user.removeFromParent()
        }
        
    }
    
    func death(){
        shade.isHidden = false
        pa.isHidden = false
        y.isHidden = false
        n.isHidden = false
    }
    
    func isDead() -> Bool{
        var returnVal = false
        if(shade.isHidden == false){
            returnVal = true
        }
        return returnVal
    }
    
}
