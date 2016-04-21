//
//  NegaScout.swift
//  Othello
//
//  Created by Jason Pierna on 11/04/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

/**
 Intelligence artificielle s'appuyant sur l'algorithme NegaScout pour déterminer le meilleur coup possible.
 - note: Correspond à la difficulté "Extrême"
 */
class NegaScout: Strategie {
    
    /**
     Permet de choisir le meilleur mouvement parmi les différents plateaux jouables. Chaque mouvement jouable est accompagné de sa valeur provenant de l'algorithme NegaScout.
     - note : L'algorithme NegaScout est utilisé avec une profondeur de 4.
     - parameters:
     - plateau: Le plateau de base.
     */
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
                
                let valeur = self.negascout(nouveauPlateau, joueur: BLANC, profondeur: 4, A: -Int(UInt16.max), B: Int(UInt16.max))
                
                print("calculMouvement valeur : \(valeur)")

                
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
    
    /**
     Implémentation de l'algorithme NegaScout consistant à étudier toutes les possibilités et à déterminer le meilleur choix possible, en introduisant le principe de la fenêtre nulle pour déterminer si le reste de l'arbre doit être parcourcu ou non.
     - parameters:
     - plateau: Le plateau de jeu concerné.
     - joueur: Le joueur concerné.
     - profondeur: La profondeur de l'algorithme.
     - returns: La valeur du meilleur coup
     */
    func negascout(plateau: Plateau, joueur: Int, profondeur: Int, A: Int, B: Int) -> Int {
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        
        if profondeur == 0 || mouvementsPossibles.isEmpty {
            return self.fonctionEvaluation(plateau, joueur: BLANC)
        }
        
        var a = A
        var b = B
        
        for mouvement in mouvementsPossibles {
            let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
            
            let valeur = -self.negascout(nouveauPlateau, joueur: -joueur, profondeur: profondeur-1, A: -b, B: -a)
            
            if valeur > a && valeur < B {
                a = -self.negascout(nouveauPlateau, joueur: -joueur, profondeur: profondeur-1, A: -B, B: -valeur)
            }
            
            a = (a > valeur) ? a : valeur
            
            if a >= B {
                return a
            }
            b = a + 1
        }
        
        return a
        
    }
}