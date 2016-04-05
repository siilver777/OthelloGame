//
//  AlphaBetaStrategy.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

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
                
                let valeur = self.minmax(nouveauPlateau, joueur: BLANC, profondeur: 3, A: Int(UInt8.min), B: Int(UInt8.max))
                
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