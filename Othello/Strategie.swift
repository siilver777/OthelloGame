//
//  Strategie.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Strategie {
    let gameViewController: GameViewController
    
    required init(controller: GameViewController) {
        self.gameViewController = controller
    }
    
    func computeNextMoveForBoard(board: Plateau) {
        //NSException.raise(NSInternalInconsistencyException, format: "Méthode abstraite", NSString(string: ""))
        print("Méthode abstraite")
    }
    
    func calculMouvement(plateau: Plateau) {
       print("erreur")
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
} 