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
    @IBOutlet weak var window2: NSWindow!
    
    @IBOutlet weak var boardMatrix: NSMatrix!
    @IBOutlet weak var blackScoreField: NSTextField!
    @IBOutlet weak var whiteScoreField: NSTextField!
    @IBOutlet weak var passButton: NSButton!
    @IBOutlet weak var waitSpinner: NSProgressIndicator!
    @IBOutlet weak var newGameMenuItem: NSMenuItem!
    @IBOutlet weak var messageField: NSTextField!
    @IBOutlet weak var playersMenu: NSMenu!
    @IBOutlet weak var difficultyMenu: NSMenu!
    
    var gameViewController: GameViewController!
    
    // MARK: - Constantes
    
    let default_player = 1
    let default_diff = 2
    
    // Variables
    
    /*var currentBoard: Board?
    var currentPlayer: Int!
    var blackScore: Int?
    var whiteScore: Int?
    var blackStrategy: Strategy?
    var whiteStrategy: Strategy?
    var aiOpQueue: NSOperationQueue?
    var players: Int?
    var difficulty: Int?*/

    // MARK: - NSApplicationDelegate
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
        window2.contentView?.addSubview(gameViewController.view)
        gameViewController.view.frame = window2.contentView!.bounds
    }


    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        NSApp.delegate = self
        //self.players = default_player
        //self.difficulty = default_diff
    }
    /*
    @IBAction func matrixButtonClicked(sender: AnyObject) {
        let row = sender.selectedRow
        let col = sender.selectedColumn
        
        //let coord = Coord(row: row+1, column: col+1)
        //self.move(coord)
    }
    
    @IBAction func passButtonClicked(sender: AnyObject) {
        self.pass()
    }
    
    @IBAction func newGame(sender: AnyObject) {
        self.newGame()
    }
    
    @IBAction func difficultyMenuItemClicked(sender: AnyObject) {
        difficulty = sender.tag()
        
        self.updateOptionMenus()
        self.newGame()
    }
    
    @IBAction func playersMenuItemClicked(sender: AnyObject) {
        players = sender.tag()
        
        self.updateOptionMenus()
        self.newGame()
    }
    
    @IBAction func helpClicked(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://en.wikipedia.org/wiki/Reversi")!)
    }
    
    func updateOptionMenus() {
        let playerItems = playersMenu.itemArray
        
        for item in playerItems {
            item.state = (item.tag == players) ? NSOnState : NSOffState
        }
        
        let diffItems = difficultyMenu.itemArray
        
        for item in diffItems {
            item.state = (item.tag == difficulty) ? NSOnState : NSOffState
        }
    }
    
    func setMenuItemsEnabled(state: Bool) {
        newGameMenuItem.enabled = state
        
        let playerItems = playersMenu.itemArray
        
        for item in playerItems {
            item.enabled = state
        }
        
        let diffItems = difficultyMenu.itemArray
        
        for item in diffItems {
            item.enabled = state
        }
        
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