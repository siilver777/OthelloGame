//
//  GameViewController.swift
//  Othello
//
//  Created by Jason Pierna on 26/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Cocoa

class GameViewController: NSViewController {
    
    @IBOutlet weak var scoreNoirTextField: NSTextField!
    @IBOutlet weak var scoreBlancTextField: NSTextField!
    @IBOutlet weak var plateauMatrix: NSMatrix!
    @IBOutlet weak var messageTextField: NSTextField!
    @IBOutlet weak var difficultePopUpButton: NSPopUpButton!
    
    var plateau: Plateau!
    var joueurActuel: Int!
    var difficulte: Strategie?
    var queue: OperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ajout des difficultés au menu
        difficultePopUpButton.addItems(withTitles: ["Très facile", "Facile", "Moyen", "Difficile", "Extrême"])
        
        // Difficulté par défaut (facile)
        difficulte = Aleatoire(controller: self)
        
        // Lancer une nouvelle partie
        nouvellePartie()
    }
    
    @IBAction func caseSelectionnee(_ sender: AnyObject) {
        let mouvement = Coordonnees(ligne: sender.selectedRow+1, colonne: sender.selectedColumn+1)
        self.mouvement(mouvement)
    }
    
    @IBAction func recommencer(_ sender: AnyObject) {
        nouvellePartie()
    }
    
    @IBAction func changerDifficulte(_ sender: AnyObject) {
        switch difficultePopUpButton.indexOfSelectedItem {
        case 1:
            difficulte = Heuristique(controller: self)
        case 2:
            difficulte = Minimax(controller: self)
        case 3:
            difficulte = AlphaBeta(controller: self)
        case 4:
            difficulte = NegaScout(controller: self)
        default:
            difficulte = Aleatoire(controller: self)
        }
        
        self.nouvellePartie()
    }
    
    func afficherPlateau() {
        var scoreNoir = 0
        var scoreBlanc = 0
        
        for i in 0..<8 {
            for j in 0..<8 {
                let etatCase = plateau.etatCase(i+1, colonne: j+1)
                let cell = plateauMatrix.cell(atRow: i, column: j) as! NSButtonCell
                
                // On active la cellule seulement si le mouvement est possible par l'utilisateur
                if joueurActuel == NOIR && plateau.isMouvementPossible(joueurActuel, ligne: i + 1, colonne: j + 1) {
                    cell.isEnabled = true
                    cell.image = NSImage(named: "jouable")
                }
                else {
                    cell.isEnabled = false
                    cell.image = nil
                }
                
                switch(etatCase) {
                case BLACK:
                    cell.image = NSImage(named: "blackpiece")
                    scoreNoir += 1
                case WHITE:
                    cell.image = NSImage(named: "whitepiece")
                    scoreBlanc += 1
                default:
                    break
                }
            }
        }
        
        scoreNoirTextField.stringValue = "\(scoreNoir)"
        scoreBlancTextField.stringValue = "\(scoreBlanc)"
    }
    
    func nouvellePartie() {
        // Le joueur commence
        joueurActuel = NOIR
        
        if (queue != nil) {
            queue?.cancelAllOperations()
        }
        else {
            queue = OperationQueue()
        }
        
        if plateau != nil {
            plateau.reset()
        }
        else {
            plateau = Plateau()
        }
        
        // On attend le prochain mouvement
        mouvementSuivant()
    }
    
    func mouvement(_ coordonnees: Coordonnees) {
        plateau.mouvement(joueurActuel, ligne: coordonnees.ligne, colonne: coordonnees.colonne)
        
        // On change de joueur et on attend le prochain mouvement
        changerJoueur()
        mouvementSuivant()
    }
    
    func changerJoueur() {
        joueurActuel = (joueurActuel == BLANC) ? NOIR : BLANC
    }
    
    func mouvementSuivant() {
        // Mise à jour de l'interface graphique
        self.afficherPlateau()
        
        // On récupère les mouvements possibles
        let mouvementsNoir = plateau.mouvementsPossibles(NOIR)
        let mouvementsBlanc = plateau.mouvementsPossibles(BLANC)
        
        if mouvementsNoir.isEmpty && mouvementsBlanc.isEmpty {
            
            // Fin du jeu, on détermine le gagnant
            if scoreNoirTextField.intValue == scoreBlancTextField.intValue {
                // Egalité
                messageTextField.stringValue = "Terminé ! C'est une égalité."
            }
            else if (scoreNoirTextField.intValue > scoreBlancTextField.intValue) {
                // Noir gagne
                messageTextField.stringValue = "Terminé ! Victoire des Noirs."
            }
            else {
                // Blanc gagne
                messageTextField.stringValue = "Terminé ! Victoire des Blancs."
            }
        }
        else {
            if joueurActuel == BLANC {
                // L'IA est en train de jouer
                messageTextField.stringValue = "L'IA est en train de jouer"
                
                queue?.addOperation(BlockOperation { [unowned self] in
                    self.difficulte!.calculMouvement(plateau: self.plateau)
				})
            }
            else {
                // À vous de jouer
                messageTextField.stringValue = "À vous de jouer"
                
                if mouvementsNoir.isEmpty {
                    passer()
                }
            }
        }
    }
    
    func passer() {
        changerJoueur()
        mouvementSuivant()
    }
}
