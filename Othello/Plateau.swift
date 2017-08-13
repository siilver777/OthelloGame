//
//  Plateau.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class Plateau {
    var etatPlateau: [Int]
    
    init() {
        self.etatPlateau = PLATEAU_DEPART
    }
    
    init(plateau: Plateau) {
        self.etatPlateau = plateau.etatPlateau
    }
    
    func etatCase(_ ligne: Int, colonne: Int) -> Int {
        return self.etatPlateau[ligne * 10 + colonne]
    }
    
    func isMouvementPossible(_ joueur: Int, ligne: Int, colonne: Int) -> Bool {
        let caseDemandee = ligne * 10 + colonne
        
        if self.etatPlateau[caseDemandee] != CASE_VIDE {
            return false
        }
        
        let adversaire = -joueur
        
        for direction in DIRECTIONS {
            var voisin = caseDemandee + direction
            
            if self.etatPlateau[voisin] == adversaire {
                repeat {
                    voisin += direction
                } while self.etatPlateau[voisin] == adversaire
                
                if self.etatPlateau[voisin] == joueur {
                    return true
                }
            }
        }
        
        return false
    }
    
    func mouvementsPossibles(_ joueur: Int) -> [Coordonnees] {
        var mouvements: [Coordonnees] = []
        
        for ligne in 1...8 {
            for colonne in 1...8 {
                if self.isMouvementPossible(joueur, ligne: ligne, colonne: colonne) {
                    let mouvement = Coordonnees(ligne: ligne, colonne: colonne)
                    mouvements.append(mouvement)
                }
            }
        }
        
        return mouvements
    }
    
    func mouvement(_ joueur: Int, ligne: Int, colonne: Int) {
        let caseDemandee = ligne * 10 + colonne
        let adversaire = -joueur
        
        self.etatPlateau[caseDemandee] = joueur
        
        for direction in DIRECTIONS {
            var voisin = caseDemandee + direction
            
            if self.etatPlateau[voisin] == adversaire {
                repeat {
                    voisin += direction
                } while self.etatPlateau[voisin] == adversaire
                
                if self.etatPlateau[voisin] == joueur {
                    repeat {
                        self.etatPlateau[voisin] = joueur
                        voisin -= direction
                    } while self.etatPlateau[voisin] == adversaire
                }
            }
        }
    }
    
    func reset() {
        self.etatPlateau = PLATEAU_DEPART
    }
    
    func score(_ joueur: Int) -> Int {
        var score = 0
        
        for ligne in 1..<9 {
            for colonne in 1..<9 {
                if self.etatPlateau[ligne * 10 + colonne] == joueur {
                    score += 1
                }
            }
        }
        
        return score
    }
    
    func voisins(_ ligne: Int, colonne: Int) -> [Coordonnees] {
        var voisins: [Coordonnees] = []
        let caseDemandee = ligne * 10 + colonne
        
        for direction in DIRECTIONS {
            let voisin = caseDemandee + direction
            
            if voisin < 100 && voisin >= 0 && self.etatPlateau[voisin] != BORD_PLATEAU {
                voisins.append(Coordonnees(ligne: voisin/10, colonne: voisin%10))
            }
        }
        
        return voisins
    }
    
}
