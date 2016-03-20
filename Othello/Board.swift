//
//  Board.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

let EMPTY = 0
let BLACK = 1
let WHITE = -1
let BORDER = 3


class Board {
    let directions = [-11, -10, -9, -1, 1, 9, 10, 11]
    
    var grid: [Int]
    
    let initBoard = [
        BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, BORDER,
        BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER, BORDER
    ]
    
    init() {
        self.grid = self.initBoard
    }
    
    init(other: Board) {
        self.grid = other.grid
    }
    
    func square(row: Int, column: Int) -> Int {
        return self.grid[row * 10 + column]
    }
    
    func isLegalForMovePlayer(player: Int, row: Int, column: Int) -> Bool {
        let l0 = row * 10 + column
        
        if self.grid[l0] != EMPTY {
            return false
        }
        
        let otherPlayer = -player
        
        for i in 0..<8 {
            let d = self.directions[i]
            var l1 = l0 + d
            
            if self.grid[l1] == otherPlayer {
                repeat {
                    l1 += d
                } while self.grid[l1] == otherPlayer
                
                if self.grid[l1] == player {
                    return true
                }
            }
        }
        
        return false
    }
    
    func legalMovesForPlayer(player: Int) -> [Coord] {
        
        var legalMoves: [Coord] = []
        
        for row in 1...8 {
            for column in 1...8 {
                if self.isLegalForMovePlayer(player, row: row, column: column) {
                    let move = Coord(row: row, column: column)
                    legalMoves += [move]
                }
            }
        }
        
        return legalMoves
    }
    
    func noMovesForPlayer(player: Int) -> Bool {
        for row in 1...8 {
            for column in 1...8 {
                if self.isLegalForMovePlayer(player, row: row, column: column) {
                    return false
                }
            }
        }
        return false
    }
    
    func makeMoveForPlayer(player: Int, row: Int, column: Int) {
        let l0 = row * 10 + column
        let otherPlayer = -player
        
        self.grid[l0] = player
        
        for i in 0..<8 {
            let d = directions[i]
            var l1 = l0 + d
            
            if self.grid[l1] == otherPlayer {
                repeat {
                    l1 += d
                } while grid[l1] == otherPlayer
            }
        }
    }
    
    func reset() {
        self.grid = self.initBoard
    }
    
    func scoreForPLayer(player: Int) -> Int {
        var score = 0
        
        for row in 1..<9 {
            for column in 1..<9 {
                if grid[row * 10 + column] == player {
                    ++score
                }
            }
        }
        
        return score
    }
    
    func neighborsOfRow(row: Int, column: Int) -> [Coord] {
        
        var ret: [Coord] = []
        let l0 = row * 10 + column
        
        for i in 0..<8 {
            let l1 = l0 + self.directions[i]
            
            if l1 < 100 && l1 >= 0 && grid[l1] != BORDER {
                let coord = Coord(row: l1/10, column: l1 % 10)
                ret += [coord]
            }
        }
        
        return ret
    }
    
}