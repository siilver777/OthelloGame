//
//  Aleatoire.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

/**
 Intelligence artificielle choisissant le coup à jouer de manière aléatoire à partir de ses mouvements possibles.
 - note: Correspond à la difficulté "Très facile"
 */
class Aleatoire: Strategie {
    
    /**
     Permet de choisir un mouvement aléatoire parmi les mouvements possibles.
     - parameters:
     - plateau: Le plateau de base.
     */
    override func calculMouvement(_ plateau: Plateau) {
        let date = Date()
        
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        
        if mouvementsPossibles.isEmpty {
            self.pause(date)
            self.passer()
        }
        else {
            self.pause(date)
            self.mouvement(mouvementsPossibles[Int(arc4random()) % mouvementsPossibles.count])
        }
    }
}
