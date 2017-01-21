//
//  ListViewController.swift
//  Single App

import UIKit

protocol ListGameViewControllerDelegate {
    func listGameViewControllerBack(_ overGameViewController: ListViewController)
}

class ListViewController: UIViewController {
    @IBOutlet weak var topScoreLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    var delegate: ListGameViewControllerDelegate!
    
    @IBAction func backButton(_ sender: AnyObject) {
       delegate.listGameViewControllerBack(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
