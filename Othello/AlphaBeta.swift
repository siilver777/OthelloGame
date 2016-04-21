//
//  AlphaBeta.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

/**
 Intelligence artificielle s'appuyant sur l'algorithme AlphaBeta pour déterminer le meilleur coup possible.
 - note: Correspond à la difficulté "Difficile"
 */
class AlphaBeta: Strategie {
    
    /**
     Permet de choisir le meilleur mouvement parmi les différents plateaux jouables. Chaque mouvement jouable est accompagné de sa valeur provenant de l'algorithme AlphaBeta.
     - note : L'algorithme AlphaBeta est utilisé avec une profondeur de 3.
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
                
                let valeur = self.alphabeta(nouveauPlateau, joueur: BLANC, profondeur: 3, A: -Int(UInt16.max), B: Int(UInt16.max))
                
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
    
    /**
     Implémentation de l'algorithme AlphaBeta consistant à étudier toutes les possibilités et à déterminer le meilleur choix possible, c'est-à-dire le coup minimisant les pertes du joueur à l'instar du Minimax, tout en réduisant le nombre de nœuds explorés.
     - parameters:
     - plateau: Le plateau de jeu concerné.
     - joueur: Le joueur concerné.
     - profondeur: La profondeur de l'algorithme.
     - returns: La valeur du meilleur coup
     */
    func alphabeta(plateau: Plateau, joueur: Int, profondeur: Int, A: Int, B: Int) -> Int {
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        var a = A
        var b = B
        
        if profondeur == 0 || mouvementsPossibles.isEmpty {
            return self.fonctionEvaluation(plateau, joueur: BLANC)
        }
        
        for mouvement in mouvementsPossibles {
            let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
            
            let indice = self.alphabeta(nouveauPlateau, joueur: -joueur , profondeur: profondeur-1, A: A, B: B)
            
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