//
//  RandowStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class RandomStrategy: Strategy {
    override func computeNextMoveForBoard(board: Board) {
        NSThread.sleepForTimeInterval(START_SLEEP_TIME)
        
        var legalMoves = board.legalMovesForPlayer(player)
        
        if legalMoves.count == 0 {
            self.sendPass()
        } else {
            self.sendMove(legalMoves[random() % legalMoves.count])
        }
    }
}