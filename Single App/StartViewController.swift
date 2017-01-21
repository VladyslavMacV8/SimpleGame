//
//  StartViewController.swift
//  Single App

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var aboutButtonOutlet: UIButton!
    
    @IBOutlet weak var crownImageView: UIImageView!
    
    @IBAction func back(_ segue: UIStoryboardSegue) {}
    
    @IBAction func playButton(_ sender: AnyObject) {}
    @IBAction func aboutButton(_ sender: AnyObject) {}
    
    var maxOne = true
    
    var rotationDeagree: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationforPlay()
        circleAnimation(crownImageView)
    }

    func animationforPlay() {
        maxOne = !maxOne
        let duration: Double = 1
        let fullCircle = 2 * M_PI
        
        let upAndDown = maxOne ? CGFloat(-1 / 16 * fullCircle) : CGFloat(1 / 16 * fullCircle)
        let scale: CGFloat = maxOne ? 0.7 : 1.1
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
            let rotation = CGAffineTransform(rotationAngle: upAndDown)
            let scale = CGAffineTransform(scaleX: scale, y: scale)
            
            self.playButtonOutlet.transform = rotation.concatenating(scale)
            }) { (finished) -> Void in
                self.animationforPlay()
        }
    }
    
    func circleAnimation(_ withObject: UIImageView) {
        UIView.animate(withDuration: 0.01, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            withObject.transform = CGAffineTransform(rotationAngle: self.rotationDeagree)
            }) { (finished) -> Void in
                self.rotationDeagree += CGFloat(M_PI / 180)
                self.circleAnimation(withObject)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

