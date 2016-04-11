//
//  NegaScout.swift
//  Othello
//
//  Created by Jason Pierna on 11/04/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

class NegaScout: Poids {
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
                
                let valeur = self.negascout(nouveauPlateau, joueur: BLANC, profondeur: 8, A: Int(UInt8.min), B: Int(UInt8.max))
                
                if meilleurMouvement == nil || valeur > meilleureValeur {
                    meilleurMouvement = mouvement
                    meilleureValeur = valeur
                }
            }
            
            self.pause(date)
            self.mouvement(meilleurMouvement!)
        }
    }
    
    func negascout(plateau: Plateau, joueur: Int, profondeur: Int, A: Int, B: Int) -> Int {
        let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
        var a = A
        
        if profondeur == 0 || mouvementsPossibles.isEmpty {
            return self.utiliteCoins(plateau, joueur: BLANC, negation: true)
        }
        
        var meilleureValeur = Int(UInt.min)
        
        for mouvement in mouvementsPossibles {
            let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
            
            let valeur = -self.negascout(nouveauPlateau, joueur: -joueur , profondeur: profondeur-1, A: -B, B: -A)
            
            if valeur > meilleureValeur {
                meilleureValeur = valeur
                
                if meilleureValeur > a {
                    a = meilleureValeur
                    
                    if a > B {
                        return meilleureValeur
                    }
                }
            }
        }
        
        return meilleureValeur
    }
}
/*
private int NegaAlphaBeta(Board board, int player,int profondeur,int alpha,int beta) {
    int valeur,Best,i;
    Board cp;
    
    if(profondeur == MAXDEPTH || board.getBilles(player).size() == 8)
    return fctEvaluation(board, player);
    ArrayList<int[]> moves = board.getMouvements(player);
    
    Best=-Integer.MAX_VALUE;
    
    int joueur ;
    if(player == 2)
    joueur = 1;
    else
    joueur = 2;
    for (i=0; i<moves.size(); i++) {
        cp = new Board(player, copyArray(board.getBoard()));
        cp.move(moves.get(i), player);
        valeur=-NegaAlphaBeta(cp,joueur,profondeur+1,-beta,-alpha);
        if (valeur>Best) {
            Best=valeur;
            if (Best>alpha) {
                alpha=Best;
                if (alpha>beta) return Best;
            }
        }
    }
    return Best;
}*/