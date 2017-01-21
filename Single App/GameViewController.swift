//
//  GameViewController.swift
//  Single App

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var gameScene: GameScene!
    var pausedViewController: PausedViewController!
    var gameSetting: GameSetting!
    var overViewController: OverViewController!
    var listViewController: ListViewController!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func pauseButton(_ sender: AnyObject) {
        gameScene.pausedGame()
        showScreen(pausedViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSetting = GameSetting()
        
        pausedViewController = storyboard?.instantiateViewController(withIdentifier: "pausedViewController") as! PausedViewController
        pausedViewController.delegate = self
        
        overViewController = storyboard?.instantiateViewController(withIdentifier: "overViewController") as! OverViewController
        overViewController.delegate = self
        overViewController.gameSetting = gameSetting
        
        listViewController = storyboard?.instantiateViewController(withIdentifier: "listViewController") as! ListViewController
        listViewController.delegate = self
        
        if let scene = GameScene(fileNamed:"GameScene") {
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true

            skView.ignoresSiblingOrder = true
            
            gameScene = scene
            gameScene.gameDelegate = self
            gameScene.gameSetting = gameSetting
            
            scoreLabel.text = "\(gameSetting.currentScore)"
            
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func showScreen(_ viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        
        viewController.view.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            viewController.view.alpha = 1
        }) 
    }
    
    func hideScreen(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        
        viewController.view.alpha = 1
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            viewController.view.alpha = 0
            }, completion: { (complete: Bool) -> Void in
                viewController.view.removeFromSuperview()
        }) 
    }
    
    func loadScore() {
        let topScoreDefaultLoad = UserDefaults.standard
        if topScoreDefaultLoad.value(forKey: "keyTopScore") != nil {
            if gameSetting.topScore < gameSetting.currentScore {
                gameSetting.topScore = gameSetting.currentScore
                topScoreDefaultLoad.set(gameSetting.topScore, forKey: "keyTopScore")
            }
            gameSetting.topScore = topScoreDefaultLoad.value(forKey: "keyTopScore") as! Int
        } else {
            topScoreDefaultLoad.set(0, forKey: "keyTopScore")
            if gameSetting.topScore < gameSetting.currentScore {
                gameSetting.topScore = gameSetting.currentScore
                topScoreDefaultLoad.set(gameSetting.topScore, forKey: "keyTopScore")
            }
        }
    }
    
    func saveScore() {
        UserDefaults.standard.set(gameSetting.topScore, forKey: "keyTopScore")
    }
}

extension GameViewController: ListGameViewControllerDelegate {
    func listGameViewControllerBack(_ overGameViewController: ListViewController) {
        hideScreen(listViewController)
    }
}

extension GameViewController: GameDelegate {
    func gameDelegateDidUpdateScore(_ score: Int) {
        scoreLabel.text = "\(self.gameSetting.currentScore)"
    }
    
    func gameDelegateGameOver() {
        showScreen(overViewController)
    }
    
    func gameDelegateReset() {
        scoreLabel.text = "\(self.gameSetting.currentScore)"
    }
}

extension GameViewController: PausedViewControllerDelegate {
    func pauseViewControllerUnpaused(_ viewController: PausedViewController) {
        hideScreen(pausedViewController)
        gameScene.unpausedGame()
    }
    
    func pauseViewControllerMenu(_ viewController: PausedViewController) {}
}

extension GameViewController: OverViewControllerDelegate {
    func overGameViewControllerReset(_ overGameViewController: OverViewController) {
        gameScene.resetGame()
        hideScreen(overViewController)
    }
    
    func overGameViewControllerList(_ overGameViewController: OverViewController) {
        showScreen(listViewController)

        loadScore()
        
        listViewController.currentLabel.text = "\(gameSetting.currentScore)"
        listViewController.topScoreLabel.text = "\(gameSetting.topScore)"

        saveScore()
    }
    
    func overGameViewControllerMenu(_ overGameViewController: OverViewController) {}
}
