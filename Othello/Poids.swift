//
//  WeightedStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Poids: Strategie {
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
    
    let coins = [11, 18, 81, 88]
    
    func utilite(plateau: Plateau, joueur: Int, negation: Bool) -> Int {
        var utilite = 0
        
        for i in 1...8 {
            for j in 1...8 {
                let caseCourante = plateau.etatCase(i, colonne: j)
                if caseCourante == joueur {
                    utilite += self.weights[i * 10 + j]
                }
                else if (negation && caseCourante == -joueur) {
                    utilite -= self.weights[i * 10 + j]
                }
            }
        }
        
        return utilite
    }
    
    func utiliteCoins(plateau: Plateau, joueur: Int, negation: Bool) -> Int {
        var utilite = self.utilite(plateau, joueur: joueur, negation: negation)
        
        for coin in self.coins {
            let ligne = coin / 10
            let colonne = coin % 10
            
            if plateau.etatCase(ligne, colonne: colonne) != CASE_VIDE {
                
                
                let voisins = plateau.voisins(ligne, colonne: colonne)
                
                for voisin in voisins {
                    let indice = voisin.ligne * 10 + voisin.colonne
                    let etatCase = plateau.etatCase(voisin.ligne, colonne: voisin.colonne)
                    
                    if etatCase != EMPTY {
                        
                        utilite += (5 - self.weights[indice])
                        utilite *= (etatCase == joueur) ? 1 : -1
                    }
                }
            }
        }
        
        return utilite
    }
}

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