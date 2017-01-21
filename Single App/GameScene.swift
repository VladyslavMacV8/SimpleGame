//
//  GameScene.swift
//  Single App

import SpriteKit

protocol GameDelegate {
    func gameDelegateDidUpdateScore(_ score: Int)
    func gameDelegateGameOver()
    func gameDelegateReset()
}

enum CollisionCategories: UInt32 {
    case bird = 1
    case walls = 2
    case level = 3
    case score = 4
}

let kEasySpawnDelay : Float = 3.75
let kStandartSpawnDelay : Float = 3.0
let kHardSpawnDelay : Float = 2.0

var kCurrentlySpawnDelay = kEasySpawnDelay

let kFirstDelaySpeed : Float = 1.0

let kEasyGroundSpeed : Float = 75
let kStandartGroundSpeed : Float = 125
let kHardGroundSpeed : Float = 200

var kCurrentlyGroundSpeed = kEasyGroundSpeed

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameDelegate: GameDelegate?
    var gameSetting: GameSetting!
    
    var bird: SKSpriteNode!
    
    var walls: SKNode!
    var actions: SKNode!
    var animationLayer: SKNode!
    
    var wallTextureTop:SKTexture!
    var wallTextureBot:SKTexture!
    
    var allActionWalls:SKAction!
    var wildFly: SKAction!
    var hit: SKAction!
    
    var onPause: Bool!
    var gameOver: Bool!
    var restarted = Bool()
    
    var lastHit = false
    
    let timer = CountdownLabel()
    
    var delaySpeed = UserDefaults.standard.integer(forKey: "delaySpeed")
    var groundSpeed = UserDefaults.standard.integer(forKey: "groundSpeed")
        
    func pausedGame() {
        onPause = true
        bird.isPaused = true
        physicsWorld.speed = 0
        walls.isPaused = true
        animationLayer.isPaused = true
        actions.isPaused = true
    }
    
    func unpausedGame() {
        onPause = false
        bird.isPaused = false
        physicsWorld.speed = 1
        walls.isPaused = false
        animationLayer.isPaused = false
        actions.isPaused = false
        
        timer.startWithDuration(3)
    }
    
    func resetGame() {
        gameSetting.reset()
        gameDelegate?.gameDelegateReset()
        gameOver = false
        
        bird.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.7)
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.collisionBitMask = CollisionCategories.level.rawValue | CollisionCategories.walls.rawValue
        bird.speed = 1.0
        bird.zRotation = 0.0
        
        walls.removeAllChildren()
        
        restarted = false
        onPause = false
        lastHit = false
        
        actions.speed = 1
        
        unpausedGame()
        
        timer.startWithDuration(3)
    }
    
    func timers() {
        if !onPause {
            if !timer.hasFinished() {
                timer.isHidden = false
                bird.speed = 0
                physicsWorld.speed = 0
                walls.speed = 0
                actions.speed = 0
                
            } else if timer.hasFinished() {
                timer.isHidden = true
                bird.speed = 1
                physicsWorld.speed = 1
                walls.speed = 1
                actions.speed = 1
            }
        }
    }
    
    func settingChanged() {
        let defaults = UserDefaults.standard
        delaySpeed = defaults.integer(forKey: "delaySpeed")
        if delaySpeed == 0 {
            kCurrentlySpawnDelay = kEasySpawnDelay
        } else if delaySpeed == 1 {
            kCurrentlySpawnDelay = kStandartSpawnDelay
        } else if delaySpeed == 2 {
            kCurrentlySpawnDelay = kHardSpawnDelay
        }
        
        groundSpeed = defaults.integer(forKey: "groundSpeed")
        if groundSpeed == 0 {
            kCurrentlyGroundSpeed = kEasyGroundSpeed
        } else if groundSpeed == 1 {
            kCurrentlyGroundSpeed = kStandartGroundSpeed
        } else if groundSpeed == 2 {
            kCurrentlyGroundSpeed = kHardGroundSpeed
        }
    }
    
    override func didMove(to view: SKView) {
        onPause = false
        restarted = false
        gameOver = false
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.settingChanged), name: UserDefaults.didChangeNotification, object: nil)
        
        actions = SKNode()
        addChild(actions)
        walls = SKNode()
        addChild(walls)
        
        timer.position = CGPoint(x: frame.midX, y: frame.midY * 1.2)
        timer.fontSize = 65
        timer.fontColor = UIColor.blue
        timer.zPosition = 10
        addChild(timer)
        timer.startWithDuration(3)
        
        let skyTexture = SKTexture(imageNamed: "sky2")
        
        skyTexture.filteringMode = SKTextureFilteringMode.nearest
        
        let moveSkySprite = SKAction.moveBy(x: -skyTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.1 * skyTexture.size().width * 2.0))
        let resetSkySprite = SKAction.moveBy(x: skyTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveSkySpritesForever = SKAction.repeatForever(SKAction.sequence([moveSkySprite,resetSkySprite]))
        
        for a in 0..<Int(self.frame.size.width / (skyTexture.size().width * 2.0)) + 2 {
            let spriteSky = SKSpriteNode(texture: skyTexture)
            spriteSky.setScale(1.2)
            spriteSky.zPosition = -10
            spriteSky.position = CGPoint(x: CGFloat(a) * spriteSky.size.width, y: spriteSky.size.height / 2.0)
            spriteSky.run(moveSkySpritesForever)
            actions.addChild(spriteSky)
        }
        
        let animationLevel = Bundle.main.path(forResource: "Animation", ofType: "sks")
        let animationEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: animationLevel!) as! SKEmitterNode
        animationEmitter.position = CGPoint(x: frame.width, y: frame.midY)
        animationEmitter.particlePositionRange.dy = frame.height
        animationEmitter.advanceSimulationTime(10)
        
        animationLayer = SKNode()
        animationLayer.zPosition = -8
        
        addChild(animationLayer)
        animationLayer.addChild(animationEmitter)
        
        let groundTexture = SKTexture(imageNamed: "ground5")
        
        groundTexture.filteringMode = SKTextureFilteringMode.nearest
        
        let moveGroundSprite = SKAction.moveBy(x: -groundTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.02 * groundTexture.size().width * 2.0))
        let resetGroundSprite = SKAction.moveBy(x: groundTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
        
        for b in 0..<Int(self.frame.size.width / (groundTexture.size().width * 2.0)) + 2 {
            let spriteGround = SKSpriteNode(texture: groundTexture)
            spriteGround.setScale(2.0)
            spriteGround.zPosition = -7
            spriteGround.position = CGPoint(x: CGFloat(b) * spriteGround.size.width, y: spriteGround.size.height / 2.0)
            spriteGround.run(moveGroundSpritesForever)
            actions.addChild(spriteGround)
        }
        
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: groundTexture.size().height * 2.0))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = CollisionCategories.level.rawValue
        
        actions.addChild(ground)

        spawnBird()        
        actionWalls()
    }
    
    func spawnBird() {
        let birdTexture1 = SKTexture(imageNamed: "bird1.1")
        birdTexture1.filteringMode = SKTextureFilteringMode.nearest
        let birdTexture4 = SKTexture(imageNamed: "bird1.2")
        birdTexture4.filteringMode = SKTextureFilteringMode.nearest
        
        let animationBird = SKAction.animate(with: [birdTexture1, birdTexture4], timePerFrame: 0.5)
        let animationBiredForever = SKAction.repeatForever(animationBird)
        
        bird = SKSpriteNode(texture: birdTexture1)
        bird.setScale(0.1)
        bird.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.7)
        bird.run(animationBiredForever)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2.0)
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.allowsRotation = false
        
        bird.physicsBody?.categoryBitMask = CollisionCategories.bird.rawValue
        bird.physicsBody?.collisionBitMask = CollisionCategories.level.rawValue | CollisionCategories.walls.rawValue
        bird.physicsBody?.contactTestBitMask = CollisionCategories.level.rawValue | CollisionCategories.walls.rawValue
        
        self.addChild(bird)
    }
    
    func actionWalls() {
        let spawn = SKAction.run({() in
            if !self.onPause && self.timer.hasFinished() {
                self.creatingWallsAllDifficulty()
                self.spawnWallsAllDifficulty()
            }
        })

        let firstDelay = SKAction.wait(forDuration: TimeInterval(kFirstDelaySpeed))
        let allDelay = SKAction.wait(forDuration: TimeInterval(kCurrentlySpawnDelay))
        let spawnThenDelay = SKAction.sequence([spawn, allDelay])
        let spawnThenDelayForever = SKAction.repeatForever(spawnThenDelay)
        let overallDelay = SKAction.sequence([firstDelay, spawnThenDelayForever])
        self.run(overallDelay)
        
        print(kCurrentlySpawnDelay)
        print(kCurrentlyGroundSpeed)
    }
    
    func creatingWallsAllDifficulty() {
        wallTextureTop = SKTexture(imageNamed: "wallUp04")
        wallTextureTop.filteringMode = .nearest
        wallTextureBot = SKTexture(imageNamed: "wallDown04")
        wallTextureBot.filteringMode = .nearest
        
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * wallTextureTop.size().width)
        let moveWall = SKAction.moveBy(x: -distanceToMove, y:0.0, duration: TimeInterval(Float(distanceToMove) / kCurrentlyGroundSpeed))
        let removeWall = SKAction.removeFromParent()
        allActionWalls = SKAction.sequence([moveWall, removeWall])
    }
    
    func spawnWallsAllDifficulty() {
        let wallsPair = SKNode()
        wallsPair.position = CGPoint(x:self.frame.size.width + wallTextureTop.size().width * 2, y: 0)
        wallsPair.zPosition = -9
        
        let height = UInt32(self.frame.size.height / 4)
        let y = Double(arc4random_uniform(height) + height);
        
        let wallDown = SKSpriteNode(texture: wallTextureBot)
        wallDown.position = CGPoint(x:0.0, y: y + Double(wallDown.size.height) + 120)
        
        wallDown.physicsBody = SKPhysicsBody(rectangleOf: wallDown.size)
        wallDown.physicsBody?.isDynamic = false
        wallDown.physicsBody?.categoryBitMask = CollisionCategories.walls.rawValue
        wallDown.physicsBody?.contactTestBitMask = CollisionCategories.bird.rawValue
        wallsPair.addChild(wallDown)
        
        let wallUp = SKSpriteNode(texture: wallTextureTop)
        wallUp.position = CGPoint(x:0.0, y:y)
        
        wallUp.physicsBody = SKPhysicsBody(rectangleOf: wallUp.size)
        wallUp.physicsBody?.isDynamic = false
        wallUp.physicsBody?.categoryBitMask = CollisionCategories.walls.rawValue
        wallUp.physicsBody?.contactTestBitMask = CollisionCategories.bird.rawValue
        wallsPair.addChild(wallUp)
        
        let contactNode = SKNode()
        contactNode.position = CGPoint(x:wallUp.size.width + bird.size.width / 2, y:self.frame.midY)
        contactNode.physicsBody = SKPhysicsBody(rectangleOf:CGSize(width:wallUp.size.width, height: self.frame.size.height))
        contactNode.physicsBody?.isDynamic = false
        contactNode.physicsBody?.categoryBitMask = CollisionCategories.score.rawValue
        contactNode.physicsBody?.contactTestBitMask = CollisionCategories.bird.rawValue
        wallsPair.addChild(contactNode)
        
        wallsPair.run(allActionWalls)
        walls.addChild(wallsPair)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !onPause && !gameOver {
            if actions.speed > 0 {
                for touch: UITouch in touches {
                    touch.location(in: self.view)
                    
                    bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 31))
                    
                    wildFly = SKAction.playSoundFileNamed("dragonSound.mp3", waitForCompletion: true)
                    run(wildFly)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        timer.update()
        timers()
    }
    
    func addPoints(_ point: Int) {
        gameSetting.currentScore += point
        gameDelegate?.gameDelegateDidUpdateScore(self.gameSetting.currentScore)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if actions.speed > 0 {
            if contact.bodyA.categoryBitMask & CollisionCategories.score.rawValue == CollisionCategories.score.rawValue ||
                contact.bodyB.categoryBitMask & CollisionCategories.score.rawValue == CollisionCategories.score.rawValue {
                self.addPoints(1)
            } else {
                if !lastHit {
                    lastHit = true
                    gameOver = true
                    
                    hit = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: true)
                    run(hit)
                    
                    bird.run(SKAction.rotate(byAngle: CGFloat(M_PI) * CGFloat(bird.position.y) * 0.01, duration:1), completion:{ self.bird.speed = 0 })
                    
                    let fadeOutAction = SKAction.fadeOut(withDuration: 0.05)
                    fadeOutAction.timingMode = SKActionTimingMode.easeOut
                    
                    let fadeInAction = SKAction.fadeIn(withDuration: 0.05)
                    fadeInAction.timingMode = SKActionTimingMode.easeOut
                    
                    let blinkAction = SKAction.sequence([fadeOutAction, fadeInAction])
                    let blinkReapetAction = SKAction.repeat(blinkAction, count: 10)
                    
                    let deleyAction = SKAction.wait(forDuration: 0.1)
                    
                    let gameOverAction = SKAction.run({ () -> Void in
                        self.gameDelegate?.gameDelegateGameOver()

                        self.restarted = true
                        
                        self.pausedGame() })
                    let gameOverSequence = SKAction.sequence([blinkReapetAction, deleyAction, gameOverAction])
                    bird.run(gameOverSequence)
                }
            }
        }
    }
}

class CountdownLabel: SKLabelNode {
    var endTime: Date!
    
    func update() {
        let timeLeftInt = Int(timeLeft())
        text = "\(timeLeftInt)"
    }
    
    func startWithDuration(_ duration: TimeInterval) {
        let timeNow = Date()
        endTime = timeNow.addingTimeInterval(duration)
    }
    
    func hasFinished() -> Bool {
        return timeLeft() == 0
    }
    
    fileprivate func timeLeft() -> TimeInterval {
        let now = Date()
        let remainingSeconds = endTime.timeIntervalSince(now)
        return max(remainingSeconds, 0)
    }
}
