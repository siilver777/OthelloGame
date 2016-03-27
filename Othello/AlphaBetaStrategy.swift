//
//  AlphaBetaStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

let AB_PLIES = 2

class AlphaBeta: Poids {
    override func calculMouvement(plateau: Plateau) {
        let date = NSDate()
        
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        
        if mouvementsPossibles.isEmpty {
            self.pause(date)
            self.passer()
        }
        else {
            var meilleurMouvement: Coordonnees?
            var meilleureValeur: Int?
            
            for mouvement in mouvementsPossibles {
                let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
                
                let valeur = self.minmax(nouveauPlateau, joueur: BLANC, profondeur: 2, A: Int(UInt8.min), B: Int(UInt8.max))
                
                if meilleurMouvement == nil || valeur > meilleureValeur {
                    meilleurMouvement = mouvement
                    meilleureValeur = valeur
                }
            }
            
            self.pause(date)
            self.mouvement(meilleurMouvement!)
        }
    }
    
    func minmax(plateau: Plateau, joueur: Int, profondeur: Int, A: Int, B: Int) -> Int {
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        var a = A
        var b = B
        
        if profondeur == 0 || mouvementsPossibles.isEmpty {
            return self.utiliteCoins(plateau, joueur: BLANC, negation: true)
        }
        
        for mouvement in mouvementsPossibles {
            let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
            
            let indice = self.minmax(nouveauPlateau, joueur: -joueur , profondeur: profondeur-1, A: A, B: B)
            
            if joueur != BLANC {
                if indice < b {
                    b = indice
                }
            }
            else {
                if indice > a {
                    a = indice
                }
            }
        }
        
        return (joueur != BLANC) ? b : a
    }
}

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