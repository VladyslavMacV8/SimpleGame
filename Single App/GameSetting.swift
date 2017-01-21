//
//  GameSetting.swift
//  Single App

import UIKit

class GameSetting: NSObject {
    var currentScore: Int
    var topScore: Int
    
    override init() {
        currentScore = 0
        topScore = 0
        
        super.init()
    }
   
    func reset() { currentScore = 0 }
}
