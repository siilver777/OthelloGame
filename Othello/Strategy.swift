//
//  Strategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

let START_SLEEP_TIME = 0.2

class Strategy {
    let controller: AppDelegate
    let player: Int
    
    required init(controller: AppDelegate, player: Int) {
        self.controller = controller
        self.player = player
    }
    
    func computeNextMoveForBoard(board: Board) {
        //NSException.raise(NSInternalInconsistencyException, format: "You must override in a subclass", NSString(string: <#T##NSString#>))
        print("You must override in a subclass")
    }
    
    func sendMove(move: Coord) {
        controller.performSelectorOnMainThread(Selector("move:"), withObject: move, waitUntilDone: false)
    }
    
    func sendPass() {
        controller.performSelectorOnMainThread(Selector("pass"), withObject: nil, waitUntilDone: false)
    }
    
    func sleepIfTooFast(date: NSDate) {
        let timePassed = date.timeIntervalSinceNow * -1
        
        if timePassed < START_SLEEP_TIME {
            NSLog("Sleeping for \(timePassed)")
            NSThread.sleepForTimeInterval(START_SLEEP_TIME-timePassed)
        }
    }
    
    func newBoardFromBoard(board: Board, move: Coord, player: Int) -> Board {
        let moveBoard = Board(other: board)
        moveBoard.makeMoveForPlayer(player, row: move.row, column: move.column)
        
        return moveBoard
    }
}