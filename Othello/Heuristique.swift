//
//  Heuristique.swift
//  Othello
//
//  Created by Jason Pierna on 15/04/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

/**
Intelligence artificielle calculant l'utilité des plateaux résultats de chaque coup possible et choisissant le coup avec la plus grande utilité
- note: Correspond à la difficulté "Facile"
*/
class Heuristique: Strategie {
	
	/**
	Permet de choisir le mouvement avec la plus grande heuristique parmi les mouvements possibles.
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
			
			let valeur = self.fonctionEvaluation(plateau: nouveauPlateau, joueur: BLANC)
			
			if meilleureValeur != nil && valeur > meilleureValeur! {
				meilleurMouvement = mouvement
				meilleureValeur = valeur
			}
			
			if meilleurMouvement == nil {
				meilleurMouvement = mouvement
				meilleureValeur = valeur
			}
		}
		
		self.pause(date)
		self.mouvement(coordonnees: meilleurMouvement!)
	}
}
