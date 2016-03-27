//
//  AppDelegate.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: - Interface

    @IBOutlet weak var window: NSWindow!
    
    var gameViewController: GameViewController!

    // MARK: - NSApplicationDelegate
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
        window.contentView?.addSubview(gameViewController.view)
        gameViewController.view.frame = window.contentView!.bounds
    }


    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        NSApp.delegate = self
    }
    /*
     
    @IBAction func difficultyMenuItemClicked(sender: AnyObject) {
        difficulty = sender.tag()
        
        self.updateOptionMenus()
        self.newGame()
    }

    func updateGUI() {
        blackScore  = 0
        whiteScore = 0
        
        let human = !self.currentPlayerUsingAI()
        waitSpinner.hidden = human
        boardMatrix.enabled = human
        passButton.enabled = human
        
        self.setMenuItemsEnabled(human)
        
        for j in 0..<8 {
            for i in 0..<8 {
                let square = currentBoard!.square(j+1, column: i+1)
                let cell = boardMatrix.cellAtRow(j, column: i) as! NSButtonCell
                
                cell.enabled = (human && currentBoard!.isLegalForMovePlayer(currentPlayer!, row: j+1, column: i+1))
                
                if square == EMPTY {
                    cell.image = nil
                } else if square == BLACK {
                    blackScore = blackScore! + 1
                    cell.image = NSImage(named: "blackpiece")
                } else if square == WHITE {
                    whiteScore = whiteScore! + 1
                    cell.image = NSImage(named: "whitepiece")
                }
            }
        }
        
        blackScoreField.stringValue = "\(blackScore!)"
        whiteScoreField.stringValue = "\(whiteScore!)"
    }
    
    func getNextMove() {
        self.updateGUI()
        
        let blackHasNoMoves = currentBoard!.noMovesForPlayer(BLACK)
        let whiteHasNoMoves = currentBoard!.noMovesForPlayer(WHITE)
        
        if blackHasNoMoves && whiteHasNoMoves {
            if blackScore == whiteScore {
                messageField.stringValue = "Tie game"
            } else if (blackScore > whiteScore) {
                messageField.stringValue = "Dark wins"
            } else {
                messageField.stringValue = "Light wins"
            }
            
            waitSpinner.hidden = true
            boardMatrix.enabled = false
            passButton.enabled = false
            self.setMenuItemsEnabled(true)
            
        } else {
            let playerColor = (currentPlayer == 1) ? "Dark" : "Light"
            
            if self.currentPlayerUsingAI() {
                messageField.stringValue = "\(playerColor) is thinking..."
                waitSpinner.hidden = false
                
                let strat = (currentPlayer == BLACK) ? blackStrategy : whiteStrategy
                let op: NSOperation = NSBlockOperation {
                    strat!.computeNextMoveForBoard(self.currentBoard!)
                }
                aiOpQueue!.addOperation(op)
            } else {
                messageField.stringValue = "\(playerColor)'s turn"
                waitSpinner.hidden = true
            }
        }
    }
    
    
    func allocStrategy() -> Strategy.Type {
        switch (difficulty!) {
        case 1:
            return GreedyStrategy.self
        case 2:
            return AlphaBetaStrategy.self
        default:
            return RandomStrategy.self
        }
    }
    
    func newGame() {
        let blackUsesAI = (players == 0)
        let whiteUsesAI = (players <= 1)
        
        currentPlayer = BLACK
        blackScore = 0
        whiteScore = 0
        
        if blackStrategy != nil {
            blackStrategy = nil
        }
        
        if whiteStrategy != nil {
            whiteStrategy = nil
        }
        
        if blackUsesAI || whiteUsesAI {
            if (aiOpQueue != nil) {
                aiOpQueue!.cancelAllOperations()
            }
            else {
                aiOpQueue = NSOperationQueue()
            }
        }
        
        if blackUsesAI {
            blackStrategy = self.allocStrategy().init(controller: self, player: BLACK)
        }
        
        if whiteUsesAI {
            whiteStrategy = self.allocStrategy().init(controller: self, player: BLACK)
        }
        
        if (currentBoard != nil) {
            currentBoard!.reset()
        } else {
           // currentBoard = Board()
        }
        
        self.getNextMove()
    
    }
    
    func nextPlayer() {
        self.currentPlayer = -1 * self.currentPlayer
    }
    
    /*func move(coord: Coord) {
        currentBoard!.makeMoveForPlayer(currentPlayer!, row: coord.row, column: coord.column)
        self.nextPlayer()
        self.getNextMove()
    }*/
    
    func pass() {
        self.nextPlayer()
        self.getNextMove()
    }
    
//    let allocStrategy: Strategy
    
    func currentPlayerUsingAI() -> Bool {
        return (currentPlayer == BLACK && blackStrategy != nil) || (currentPlayer == WHITE && whiteStrategy != nil)
    }*/

}