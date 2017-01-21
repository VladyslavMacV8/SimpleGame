//
//  OverViewController.swift
//  Single App

import UIKit

protocol OverViewControllerDelegate {
    func overGameViewControllerReset(_ overGameViewController: OverViewController)
    func overGameViewControllerList(_ overGameViewController: OverViewController)
    func overGameViewControllerMenu(_ overGameViewController: OverViewController)
}

class OverViewController: UIViewController {
    var delegate: OverViewControllerDelegate!
    var gameSetting: GameSetting!

    @IBAction func resetButton(_ sender: AnyObject) {
        delegate.overGameViewControllerReset(self)
    }
    
    @IBAction func listButton(_ sender: AnyObject) {
        delegate.overGameViewControllerList(self)
    }
    
    @IBAction func menuOverButton(_ sender: AnyObject) {
        delegate.overGameViewControllerMenu(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
