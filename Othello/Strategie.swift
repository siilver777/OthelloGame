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
        gameViewController = controller
    }
    
    /**
     Méthode à redéfinir à chaque sous-classe afin d'implémenter l'IA.
     */
    func calculMouvement(plateau: Plateau) {
        /* À redéfinir à chaque algorithme */
    }
    
    /**
     Permet à l'intelligence artificielle de jouer le coup décidé.
     
     - parameters:
     - mouvement: Le coup à jouer.
     */
    func mouvement(coordonnees: Coordonnees) {
        gameViewController.mouvement(coordonnees)
    }
    
    /**
     Permet à l'intelligence artificielle de passer son coup lorsqu'aucun coup n'est disponible.
     */
    func passer() {
        gameViewController.passer()
    }
    
    /**
     Définit un temps de pause minimal à l'intelligence artificielle.
     
     Si le temps de réflexion est supérieur au temps de pause, on ne provoque pas de pause supplémentaire.
     
     - parameters:
     - date: La date à laquelle l'intelligence commence à jouer.
     */
    func pause(_ date: Date) {
        let intervalle = date.timeIntervalSinceNow * -1
        
        if intervalle < TEMPS_PAUSE {
            NSLog("Temps de réflexion \(intervalle)")
            Thread.sleep(forTimeInterval: TEMPS_PAUSE-intervalle)
        }
    }
    
    /**
     Création d'un nouveau plateau de jeu avancé d'un coup supplémentaire.
     
     - parameters:
     - plateau: Le plateau de départ.
     - mouvement: Le coup à ajouter au plateau de départ.
     - returns: Le nouveau plateau de jeu.
     */
    func nouveauPlateau(_ plateau: Plateau, mouvement: Coordonnees) -> Plateau {
        let nouveauPlateau = Plateau(plateau: plateau)
        nouveauPlateau.mouvement(BLANC, ligne: mouvement.ligne, colonne: mouvement.colonne)
        
        return nouveauPlateau
    }
    
    /**
     Évalue le plateau à partir de l'état et l'heuristique de chacune de ses cases.
     
     - parameters:
     - plateau: Le plateau à évaluer.
     - joueur: Le joueur pour lequel l'utilité est calculé.
     - returns: L'utilité du plateau.
     */
    func fonctionEvaluation(plateau: Plateau, joueur: Int) -> Int {
        var utilite = 0
        
        for i in 1...8 {
            for j in 1...8 {
                let caseCourante = plateau.etatCase(i, colonne: j)
                if caseCourante == joueur {
                    utilite += heuristiques[i * 10 + j]
                }
                else if caseCourante == -joueur {
                    utilite -= heuristiques[i * 10 + j]
                }
            }
        }
        
        return utilite
    }
}
