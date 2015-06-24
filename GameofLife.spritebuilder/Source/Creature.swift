//
//  Creature.swift
//  GameofLife
//
//  Created by Boris Yue on 6/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Creature: CCSprite {
    
    var isAlive = false {
        didSet {//when isAlive is changed
            self.visible = isAlive
        }
    }
    var livingNeighborsCount = 0
    
    convenience override init() {
        self.init(imageNamed: "GameOfLifeAssets/Assets/bubble.png")
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
}