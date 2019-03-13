//
//  CMenu.swift
//  Squeeze1
//
//  Created by Nic Casson on 2017-12-02.
//  Copyright © 2017 CassonApps. All rights reserved.
//

import Foundation
import SpriteKit

class Menu : SKScene {
    
    var playButton = SKSpriteNode()
    var highScoreLabel = SKLabelNode()
    var diamondLabel = SKLabelNode()
    var garage = SKSpriteNode()
    var clickFinished = false
    
    struct glbls {
        static var diamondCount = 0 + UserDefaults.standard.integer(forKey: "diamondCount")
        static var highScore = 0 + UserDefaults.standard.integer(forKey: "highScore")
        
        static var userPlayer = UserDefaults.standard.string(forKey: "userPlayer")
        static var userImages = ["RuserImageC.png","YuserImageC.png","GuserImageC.png","BuserImageC.png","PuserImageC.png"]
    }
    
    func makeRoad() { //Adds road image as child
        for ii in 0...3 {
            let backGround = SKSpriteNode(imageNamed: "backGround.png")
            backGround.name = "backGround"
            backGround.zPosition = -1
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
    
    func clickItem(image: SKSpriteNode) -> Bool {
        image.run(SKAction.animate(with: [SKTexture.init(imageNamed: (image.name?.appending("Press"))!)], timePerFrame: 3))
        image.run(SKAction.sequence([SKAction.wait(forDuration: 0.5) ,SKAction.animate(with: [SKTexture.init(imageNamed: image.name!)], timePerFrame: 3)]))
        return true
    }//Runs the animation on clicked item
    
//    func firstThing(completion: (_ finished: Bool) -> Void){
//        clickItem(image: playButton)
//        completion(true)
//    } //This runs the animation on the image Node then proccedes to allow the scene to be rendered
    
    override func sceneDidLoad() {
        
        clickFinished = false
        
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScoreLabel.text = "Best: " + String(UserDefaults.standard.integer(forKey: "highScore"))
        
        diamondLabel = self.childNode(withName: "diamondLabel") as! SKLabelNode
        diamondLabel.text = String(UserDefaults.standard.integer(forKey: "bankAccount"))
        
        playButton = self.childNode(withName: "playBar") as! SKSpriteNode
        playButton.texture = SKTexture.init(imageNamed: "playBar")
        
        garage = self.childNode(withName: "cars") as! SKSpriteNode
        garage.texture = SKTexture.init(imageNamed: "cars")
        
        makeRoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            
            let touchPoint = touch.location(in: self)
            
            if (atPoint(touchPoint).name == "playBar")&&(clickItem(image: playButton)) {
                if let view = self.view {
                    let scene = Game(fileNamed: "GameScene")
                    // Set the scale mode to scale to fit the window
                    scene?.scaleMode = .aspectFill
                    // Present the scene
                    view.presentScene(scene!, transition: SKTransition.fade(with: UIColor.white, duration: 2))
                }
            }
            
            if (atPoint(touchPoint).name == "cars") {
                clickItem(image: garage)
                //                if let view = self.view {
                //
                //                    let scene = Garage(fileNamed: "GarageScene")
                //                    // Set the scale mode to scale to fit the window
                //                    scene?.scaleMode = .aspectFill
                //
                //                    // Present the scene
                //                    view.presentScene(scene)
                //                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //moveRoad()
    }
}
