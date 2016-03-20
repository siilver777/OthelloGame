//
//  GreedyStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class GreedyStrategy: WeightedStrategy {
    override func computeNextMoveForBoard(board: Board) {
        NSThread .sleepForTimeInterval(START_SLEEP_TIME)
        
        var legalMoves = board.legalMovesForPlayer(player)
        
        if legalMoves.count == 0 {
            self.sendPass()
        } else {
            var bestMove: Coord?
            var bestScore: Int?
            
            for i in 0..<legalMoves.count {
                let move = legalMoves[i]
                let moveBoard = self.newBoardFromBoard(board, move: move, player: player)
                
                let moveScore = self.utility(moveBoard, player: player, negation: false)
                
                if moveScore > bestScore {
                    bestMove = move
                    bestScore = moveScore
                }
            }
            
            self.sendMove(bestMove!)
        }
    }
}