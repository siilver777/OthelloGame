//
//  Minimax.swift
//  Othello
//
//  Created by Jason Pierna on 11/04/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Minimax: Strategie {
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
                
                let valeur = self.minimax(nouveauPlateau, joueur: BLANC, profondeur: 2)
                
                print("valeur : \(valeur)")
                
                if meilleurMouvement == nil || valeur > meilleureValeur {
                    meilleurMouvement = mouvement
                    meilleureValeur = valeur
                }
            }
            
            self.pause(date)
            self.mouvement(meilleurMouvement!)
            
            print("meilleure valeur : \(meilleureValeur)")
        }
    }
    
    func minimax(plateau: Plateau, joueur: Int, profondeur: Int) -> Int {
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        
        if profondeur == 0 || mouvementsPossibles.isEmpty {
            return self.fonctionEvaluation(plateau, joueur: BLANC, negation: true)
        }
        
        var meilleureValeur = Int(UInt8.min)
        
        for mouvement in mouvementsPossibles {
            let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
            
            let indice = self.minimax(nouveauPlateau, joueur: -joueur , profondeur: profondeur-1)
            
            if indice > meilleureValeur {
                meilleureValeur = indice
            }
        }
        
        return meilleureValeur
    }
}