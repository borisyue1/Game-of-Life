//
//  Grid.swift
//  GameofLife
//
//  Created by Boris Yue on 6/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

let GridRows = 8
let GridColumns = 10

class Grid: CCSprite {
    var totalAlive = 0
    var generation = 0
    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    var gridArray: [[Creature]]!//2d array
    
    // Add Grid methods below here
    override func onEnter() {//once grid(childnode) appears
        super.onEnter()
        
        setupGrid()
        
        userInteractionEnabled = true
    }
    func setupGrid() {
        
        cellWidth = contentSize.width / CGFloat(GridColumns)
        cellHeight = contentSize.height / CGFloat(GridRows)//size of each cell
        
        gridArray = []
        
        for row in 0..<GridRows {
            gridArray.append([])//creates new row of arrays
            
            for column in 0..<GridColumns {
                var creature = Creature()
                creature.position = CGPoint(x: cellWidth * CGFloat(column),
                    y: cellHeight * CGFloat(row))//increases x and y every time
                addChild(creature)
                
                gridArray[row].append(creature)
                
                creature.isAlive = false
            }
        }
    }
}