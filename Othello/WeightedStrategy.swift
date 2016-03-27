//
//  File.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

/*class WeightedStrategy: Strategy {
    let weights = [
        0,  0,      0,      0,  0,  0,  0,  0,      0,      0,
        0,  120,    -20,    20, 5,  5,  20, -20,    120,    0,
        0,  -20,    -40,    -5, -5, -5, -5, -40,    -20,    0,
        0,  20,     -5,     15,  3, 3,  15, -5,     20,     0,
        0,  5,      -5,     3,   3, 3,  3,  -5,     5,      0,
        0,  5,      -5,     3,   3, 3,  3,  -5,     5,      0,
        0,  20,     -5,     15,  3, 3,  15, -5,     20,     0,
        0,  -20,    -40,    -5, -5, -5, -5, -40,    -20,    0,
        0,  120,    -20,    20, 5,  5,  20, -20,    120,    0,
        0,  0,      0,      0,  0,  0,  0,  0,      0,      0
    ]
    
    let corners = [11, 18, 81, 88]
    
    func utility(board: Board, player: Int, negation: Bool) -> Int {
        var util = 0
        
        for i in 1..<9 {
            for j in 1..<9 {
                let v = board.square(i, column: j)
                if v == player {
                    util += weights[i * 10 + j]
                } else if (negation && v == -player) {
                    util -= weights[i * 10 + j]
                }
            }
        }
        
        return util
    }
    
    func utilityWithCornerAdjustment(board: Board, player: Int, negation: Bool) -> Int {
        var util = self.utility(board, player: player, negation: negation)
        
        for i in 0..<4 {
            let row = corners[i] / 10
            let column = corners[i] % 10
            
            if board.square(row, column: column) == EMPTY {
                continue
            }
            
            let neighbors = board.neighborsOfRow(row, column: column)
            
            for j in 0..<neighbors.count {
                let c = neighbors[j]
                let cPos = c.row * 10 + c.column
                
                let val = board.square(c.row, column: c.column)
                
                if val == EMPTY {
                    continue
                }
                
                util += (5 - weights[cPos]) * ((val == player) ? 1 : -1)
            }
        }
        
        return util
    }
}*/