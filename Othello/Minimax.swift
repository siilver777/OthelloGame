//
//  Minimax.swift
//  Othello
//
//  Created by Jason Pierna on 11/04/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Foundation

/**
Intelligence artificielle s'appuyant sur l'algorithme Minimax pour déterminer le meilleur coup possible.
- note: Correspond à la difficulté "Moyen"
*/
class Minimax: Strategie {
	
	/**
	Permet de choisir le meilleur mouvement parmi les différents plateaux jouables. Chaque mouvement jouable est accompagné de sa valeur provenant de l'algorithme Minimax.
	- note : L'algorithme Minimax est utilisé avec une profondeur de 2.
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
			
			let valeur = minimax(nouveauPlateau, joueur: BLANC, profondeur: 2)
			
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
	Implémentation de l'algorithme Minimax consistant à étudier toutes les possibilités et à déterminer le meilleur choix possible, c'est-à-dire le coup minimisant les pertes du joueur
	- parameters:
	- plateau: Le plateau de jeu concerné.
	- joueur: Le joueur concerné.
	- profondeur: La profondeur de l'algorithme.
	- returns: La valeur du meilleur coup
	*/
	func minimax(_ plateau: Plateau, joueur: Int, profondeur: Int) -> Int {
		let mouvementsPossibles = plateau.mouvementsPossibles(BLANC)
		
		if profondeur == 0 || mouvementsPossibles.isEmpty {
			return fonctionEvaluation(plateau: plateau, joueur: BLANC)
		}
		
		var meilleureValeur = Int(UInt8.min)
		
		for mouvement in mouvementsPossibles {
			let nouveauPlateau = self.nouveauPlateau(plateau, mouvement: mouvement)
			
			let indice = minimax(nouveauPlateau, joueur: -joueur , profondeur: profondeur-1)
			
			if indice > meilleureValeur {
				meilleureValeur = indice
			}
		}
		
		return meilleureValeur
	}
}
