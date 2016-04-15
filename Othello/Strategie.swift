//
//  Strategie.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Strategie {
    
    // MARK: - Attributs 
    
    let gameViewController: GameViewController
    
    /*let heuristiques = [
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
    ]*/
    
    let heuristiques = [
        0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
        0,  500,    -150,   30,     10, 10, 30, -150,   500,    0,
        0,  -150,   -250,   0,      0,  0,  0,  -250,   -150,   0,
        0,  30,     0,      1,      2,  2,  1,  0,      30,     0,
        0,  10,     0,      2,      16, 16, 2,  0,      10,     0,
        0,  10,     0,      2,      16, 16, 2,  0,      10,     0,
        0,  30,     0,      1,      2,  2,  1,  0,      30,     0,
        0,  -150,   -250,   0,      0,  0,  0,  -250,   -150,   0,
        0,  500,    -150,   30,     10, 10, 30, -150,   500,    0,
        0,  0,      0,      0,      0,  0,  0,  0,      0,      0
    ]
    
    let coins = [11, 18, 81, 88]
    
    // MARK: - Méthodes
    
    required init(controller: GameViewController) {
        self.gameViewController = controller
    }
    
    func calculMouvement(plateau: Plateau) {
       /* À redéfinir à chaque algorithme */
    }
    
    func mouvement(mouvement: Coordonnees) {
        self.gameViewController.mouvement(mouvement)
    }
    
    func passer() {
        self.gameViewController.passer()
    }
    
    func pause(date: NSDate) {
        let intervalle = date.timeIntervalSinceNow * -1
        
        if intervalle < TEMPS_PAUSE {
            NSLog("Temps de réflexion \(intervalle)")
            NSThread.sleepForTimeInterval(TEMPS_PAUSE-intervalle)
        }
    }
    
    func nouveauPlateau(plateau: Plateau, mouvement: Coordonnees) -> Plateau {
        let nouveauPlateau = Plateau(plateau: plateau)
        nouveauPlateau.mouvement(BLANC, ligne: mouvement.ligne, colonne: mouvement.colonne)
        
        return nouveauPlateau
    }
    
    func utilite(plateau: Plateau, joueur: Int, negation: Bool) -> Int {
        var utilite = 0
        
        for i in 1...8 {
            for j in 1...8 {
                let caseCourante = plateau.etatCase(i, colonne: j)
                if caseCourante == joueur {
                    utilite += self.heuristiques[i * 10 + j]
                }
                else if (negation && caseCourante == -joueur) {
                    utilite -= self.heuristiques[i * 10 + j]
                }
            }
        }
        
        return utilite
    }
    
    func fonctionEvaluation(plateau: Plateau, joueur: Int, negation: Bool) -> Int {
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
                        
                        utilite += (5 - self.heuristiques[indice])
                        utilite *= (etatCase == joueur) ? 1 : -1
                    }
                }
            }
        }
        
        return utilite
    }
}