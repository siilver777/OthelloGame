//
//  RandowStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Aleatoire: Strategie {
    override func calculMouvement(plateau: Plateau) {
        NSThread.sleepForTimeInterval(TEMPS_PAUSE)
        
        var mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
                
        if mouvementsPossibles.isEmpty {
            self.passer()
        }
        else {
            self.mouvement(mouvementsPossibles[random() % mouvementsPossibles.count])
        }
    }
}