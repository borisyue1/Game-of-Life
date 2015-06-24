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
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var touchLocation = touch.locationInNode(self)
        
        var creature = creatureForTouchPosition(touchLocation)
        
        creature.isAlive = !creature.isAlive
    }
    func creatureForTouchPosition(touchPosition: CGPoint) -> Creature {
        var row = Int(touchPosition.y / cellHeight)
        var column = Int(touchPosition.x / cellWidth)
        return gridArray[row][column]
    }
    func evolveStep(){
        //update each Creature's neighbor count
        countNeighbors()
        
        //update each Creature's state
        updateCreatures()
        
        //update the generation so the label's text will display the correct generation
        generation++
    }
    func countNeighbors(){
        for row in 0..<gridArray.count {//like 2d arrays in java
            for column in 0..<gridArray[row].count {
                
                var currentCreature = gridArray[row][column]
                currentCreature.livingNeighborsCount = 0
                
                for x in (row - 1)...(row + 1) {
                    for y in (column - 1)...(column + 1) {
                        
                        var validIndex = isValidIndex(x: x, y: y)
                        
                        if validIndex && !(x == row && y == column) {//if loc is valid and doesnt equal current loc
                            
                            var neighbor = gridArray[x][y]
                            
                            if neighbor.isAlive {
                                currentCreature.livingNeighborsCount++
                            }
                        }
                    }
                }
            }
        }
    }
    func isValidIndex(#x: Int, y: Int) -> Bool {
        return !(x < 0 || y < 0 || x >= GridRows || y >= GridColumns)
    }
    func updateCreatures(){
        totalAlive = 0
        for r in 0..<GridRows{
            for c in 0..<GridColumns{
                let liveneighbors = gridArray[r][c].livingNeighborsCount
                if(liveneighbors == 3){
                    gridArray[r][c].isAlive = true
                }
                else if liveneighbors <= 1 || liveneighbors >= 4 {
                    gridArray[r][c].isAlive = false
                }
                if gridArray[r][c].isAlive{
                    totalAlive++
                }
            }
        }
    }
}