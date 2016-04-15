//
//  Heuristique.swift
//  Othello
//
//  Created by Jason Pierna on 15/04/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Heuristique: Strategie {
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
                
                let valeur = self.fonctionEvaluation(nouveauPlateau, joueur: BLANC, negation: true)
                
                print("valeur : \(valeur)")
                
                if meilleurMouvement == nil || valeur > meilleureValeur {
                    meilleurMouvement = mouvement
                    meilleureValeur = valeur
                }
            }
            
            self.pause(date)
            self.mouvement(meilleurMouvement!)
            
            print("Calculmouvement meilleure valeur : \(meilleureValeur)")
        }
    }
}