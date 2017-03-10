//
//  Bat.swift
//  BatInvasion
//
//  Created by Aleksander Makedonski on 3/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import SpriteKit

class Bat: SKSpriteNode{
    
    
    //Timer-Related Variables
    /**
     var timeSinceLastFlyModeTransition = 0.00
     var lastUpdateInterval = 0.00
     var flyModeTransitionInterval = 2.00
     var totalGameTime = 0.00
     **/
    
    //MARK: Game Configuration Settings
    var gameDifficultyLevel: GameOptions.GameDifficulty = GameOptions.GameDifficulty.Easy
    
    var updateFunction: (Void) -> Void = { Void in }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init?(scalingFactor: CGFloat = 1.0) {
        
    
        
        guard let batTexture = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Bats)?.textureNamed("bat") else { return nil }
        
    
        let batSize = batTexture.size()
        
        self.init(texture: batTexture,color: SKColor.clear, size: batSize)
        
        configureCharacterDifficulty()
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.xScale *= scalingFactor
        self.yScale *= scalingFactor
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: batSize.width/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        
        setPosition()
        configureActions()
        configureLighting()
        
        self.run(SKAction.wait(forDuration: 1.0))
        
    }
    
    
    private func configureCharacterDifficulty(){
        gameDifficultyLevel = GameSettings.sharedInstance.getGameDifficulty() ?? GameOptions.GameDifficulty.Easy
        
        updateFunction = generateUpdateFunction()
    }
    
    
    func setPosition(){
        
        var randomXPos = Int(arc4random_uniform(UInt32(ScreenConstants.HalfScreenWidth)))
        var randomYPos = Int(arc4random_uniform(UInt32(ScreenConstants.HalfScreenHeight)))
        
        RandomizeSign(coordinateValue: &randomXPos)
        RandomizeSign(coordinateValue: &randomYPos)
        
        self.position = CGPoint(x: randomXPos, y: randomYPos)
        
    }
    
    
    
    
    private func configureActions(){
        
        guard let textureAtlas = TextureAtlasManager.sharedInstance.getTextureAtlasOfType(textureAtlasType: .Bats) else { return }
        
        let flyingAction = SKAction.animate(with: [
            textureAtlas.textureNamed("bat"),
            textureAtlas.textureNamed("bat-fly")
            ], timePerFrame: 0.25)
        let flyingAnimation = SKAction.repeatForever(flyingAction)
        self.run(flyingAnimation)
        
        
        
        
    }
    
    private func configureLighting(){
        self.lightingBitMask = 1
    }
    
    
    func checkForReposition(){
        if(position.x < -ScreenConstants.ScreenWidth/1.8 || position.x > ScreenConstants.ScreenWidth/1.8){
            setPosition()
        }
        
        if(position.y < -ScreenConstants.ScreenWidth/1.8 || position.y > ScreenConstants.ScreenHeight/1.8){
            
            setPosition()
        }
    }
    
    
    func update(){
        updateFunction()
    }
    
    
    /** Character generates a different update function based on game difficulty level
     
     **/
    private func generateUpdateFunction() -> () -> (){
        
        var updateFunction: () -> ()
        
        switch(gameDifficultyLevel){
            case .Easy:
        
                updateFunction = { Void in
                    
                    let randomVelocityTuple = self.getRandomVelocityTupleFor(maxComponentVelocityOf: 10, withVelocityYMaximumOf: 10, andVelocityXMaximumOf: 10)
                    
                    let randomXVelocity = randomVelocityTuple.xVelocityComponent
                    let randomYVelocity = randomVelocityTuple.yVelocityComponent
                    
                    let impulseVector = CGVector(dx: randomXVelocity, dy: randomYVelocity)
                    
                        self.physicsBody?.applyImpulse(impulseVector)
                }
                break
            case .Medium:
                
                updateFunction = { Void in
                    
                    let randomVelocityTuple = self.getRandomVelocityTupleFor(maxComponentVelocityOf: 20, withVelocityYMaximumOf: 20, andVelocityXMaximumOf: 20)
                    
                    let randomXVelocity = randomVelocityTuple.xVelocityComponent
                    let randomYVelocity = randomVelocityTuple.yVelocityComponent
                    
                    let impulseVector = CGVector(dx: randomXVelocity, dy: randomYVelocity)
                    
                    self.physicsBody?.applyImpulse(impulseVector)
                }
                
                break
            case .Hard:
          
                updateFunction = { Void in
                    
                    let randomVelocityTuple = self.getRandomVelocityTupleFor(maxComponentVelocityOf: 30, withVelocityYMaximumOf: 30, andVelocityXMaximumOf: 30)
                    
                    let randomXVelocity = randomVelocityTuple.xVelocityComponent
                    let randomYVelocity = randomVelocityTuple.yVelocityComponent
                
                    
                    let impulseVector = CGVector(dx: randomXVelocity, dy: randomYVelocity)
                    
                    self.physicsBody?.applyImpulse(impulseVector)
                }
                
                break
        }
        
        return updateFunction
    }
    
    private func getRandomVelocity() -> CGVector?{
        
        var randomXVelocity: Int
        var randomYVelocity: Int
    
        switch(gameDifficultyLevel){
            case .Easy:
                let randomVelocityTuple = getRandomVelocityTupleFor(maxComponentVelocityOf: 10, withVelocityYMaximumOf: 10, andVelocityXMaximumOf: 10)
                
                randomXVelocity = randomVelocityTuple.xVelocityComponent
                randomYVelocity = randomVelocityTuple.yVelocityComponent
                
                break
            case .Medium:
                let randomVelocityTuple = getRandomVelocityTupleFor(maxComponentVelocityOf: 20, withVelocityYMaximumOf: 20, andVelocityXMaximumOf: 20)
                
                randomXVelocity = randomVelocityTuple.xVelocityComponent
                randomYVelocity = randomVelocityTuple.yVelocityComponent
                break
            case .Hard:
                let randomVelocityTuple = getRandomVelocityTupleFor(maxComponentVelocityOf: 30, withVelocityYMaximumOf: 30, andVelocityXMaximumOf: 30)
                
                randomXVelocity = randomVelocityTuple.xVelocityComponent
                randomYVelocity = randomVelocityTuple.yVelocityComponent
                break
        }
        
        return CGVector(dx: randomXVelocity, dy: randomYVelocity)
        
    }
    
    
    private func getRandomVelocityTupleFor(maxComponentVelocityOf maxComponentVelocity: UInt32, withVelocityYMaximumOf yMaximum: CGFloat, andVelocityXMaximumOf xMaximum: CGFloat) -> (xVelocityComponent: Int,yVelocityComponent: Int){
        
        var randomXVelocity: Int = 0
        var randomYVelocity: Int = 0
        
        guard let currentVelocity = self.physicsBody?.velocity else { return (0,0) }
        
        let currentXVelocity = currentVelocity.dx
        let currentYVelocity = currentVelocity.dy
        
        if(currentYVelocity < yMaximum && currentXVelocity < xMaximum){
            
            randomXVelocity = Int(arc4random_uniform(maxComponentVelocity))
            randomYVelocity = Int(arc4random_uniform(maxComponentVelocity))
            
            RandomizeSign(coordinateValue: &randomXVelocity)
            RandomizeSign(coordinateValue: &randomYVelocity)
        }
        
        
        return (xVelocityComponent: randomXVelocity, yVelocityComponent: randomYVelocity)
        

    }
    
    /**
    func respondToHitAt(touchLocation: CGPoint){
        
        if self.contains(touchLocation){
            
            
            AnimationsFactory.createExplosionFor(spriteNode: self)
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: 2.0),
                SKAction.removeFromParent()
                ]))
            
        }
        
        
    }
     **/
    
    
    
}
