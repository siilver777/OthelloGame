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
    
    required init(controller: GameViewController, player: Int) {
        self.gameViewController = controller
    }
    
    func computeNextMoveForBoard(board: Plateau) {
        //NSException.raise(NSInternalInconsistencyException, format: "You must override in a subclass", NSString(string: ""))
        print("You must override in a subclass")
    }
    
    func calculMouvement(plateau: Plateau) {
       print("error")
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
            NSLog("Sleeping for \(intervalle)")
            NSThread.sleepForTimeInterval(TEMPS_PAUSE-intervalle)
        }
    }
    
    func nouveauPlateau(plateau: Plateau, mouvement: Coordonnees) -> Plateau {
        let nouveauPlateau = Plateau(plateau: plateau)
        nouveauPlateau.mouvement(BLANC, ligne: mouvement.ligne, colonne: mouvement.colonne)
        
        return nouveauPlateau
    }
} 