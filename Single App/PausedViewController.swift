//
//  PausedViewController.swift
//  Single App

import UIKit

protocol PausedViewControllerDelegate {
    func pauseViewControllerUnpaused(_ viewController: PausedViewController)
    func pauseViewControllerMenu(_ viewController: PausedViewController)
}

class PausedViewController: UIViewController {
    var delegate: PausedViewControllerDelegate!

    @IBAction func menuButton(_ sender: AnyObject) {}
    
    @IBAction func unpausedButton(_ sender: AnyObject) {
        delegate.pauseViewControllerUnpaused(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
