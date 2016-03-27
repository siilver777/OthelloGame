//
//  AlphaBetaStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

let AB_PLIES = 2

/*class AlphaBetaStrategy: WeightedStrategy {
    override func computeNextMoveForBoard(board: Board) {
        let date = NSDate()
        
        var legalMoves = board.legalMovesForPlayer(player)
        
        if legalMoves.count == 0 {
            self.sleepIfTooFast(date)
            self.sendPass()
        } else {
            var bestMove: Coord?
            var bestVal: Int?
            
            for i in 0..<legalMoves.count {
                let m = legalMoves[i]
                let mBoard = self.newBoardFromBoard(board, move: m, player: player)
                
                let v = self.minimaxAB(mBoard, player: player, depth: AB_PLIES, A: Int(UInt8.min), B: Int(UInt8.max))
                
                if (bestMove == nil || v > bestVal) {
                    bestMove = m
                    bestVal = v
                }
            }
            
            self.sleepIfTooFast(date)
            self.sendMove(bestMove!)
        }
    }
    
    func minimaxAB(board: Board, player: Int, depth: Int, var A: Int, var B: Int) -> Int {
        let legalMoves = board.legalMovesForPlayer(player)
        
        if depth == 0 || legalMoves.count == 0 {
            return self.utilityWithCornerAdjustment(board, player: player, negation: true)
        }
        
        if player != self.player {
            for i in 0..<legalMoves.count {
                let m = legalMoves[i]
                let mBoard = self.newBoardFromBoard(board, move: m, player: player)
                
                let v = self.minimaxAB(mBoard, player: -player, depth: depth-1, A: A, B: B)
                
                if (v < B) {
                    B = v
                }
            }
            
            return B
        } else {
            for i in 0..<legalMoves.count {
                let m = legalMoves[i]
                let mBoard = self.newBoardFromBoard(board, move: m, player: player)
                
                let v = self.minimaxAB(mBoard, player: -player, depth: depth-1, A: A, B: B)
                
                if (v > A) {
                    A = v
                }
            }
            
            return A
        }
    }
} */