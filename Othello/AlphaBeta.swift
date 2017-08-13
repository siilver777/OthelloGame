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
		let date = Date()
		
		let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
		
		guard !mouvementsPossibles.isEmpty else {
			pause(date)
			passer()
			return
		}
		
		var meilleurMouvement: Coordonnees?
		var meilleureValeur: Int?
		
		for mouvement in mouvementsPossibles {
			let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
			
			let valeur = alphabeta(nouveauPlateau, joueur: BLANC, profondeur: 3, A: -Int(UInt16.max), B: Int(UInt16.max))
			
			if meilleureValeur != nil && valeur > meilleureValeur! {
				meilleurMouvement = mouvement
				meilleureValeur = valeur
			}
			
			if meilleurMouvement == nil {
				meilleurMouvement = mouvement
				meilleureValeur = valeur
			}
		}
		
		pause(date)
		mouvement(coordonnees: meilleurMouvement!)		
	}
	
	/**
	Implémentation de l'algorithme AlphaBeta consistant à étudier toutes les possibilités et à déterminer le meilleur choix possible, c'est-à-dire le coup minimisant les pertes du joueur à l'instar du Minimax, tout en réduisant le nombre de nœuds explorés.
	- parameters:
	- plateau: Le plateau de jeu concerné.
	- joueur: Le joueur concerné.
	- profondeur: La profondeur de l'algorithme.
	- returns: La valeur du meilleur coup
	*/
	func alphabeta(_ plateau: Plateau, joueur: Int, profondeur: Int, A: Int, B: Int) -> Int {
		let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
		var a = A
		var b = B
		
		if profondeur == 0 || mouvementsPossibles.isEmpty {
			return fonctionEvaluation(plateau: plateau, joueur: BLANC)
		}
		
		for mouvement in mouvementsPossibles {
			let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
			
			let indice = alphabeta(nouveauPlateau, joueur: -joueur , profondeur: profondeur - 1, A: A, B: B)
			
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
