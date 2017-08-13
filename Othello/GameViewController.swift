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
        self.difficulte = Aleatoire(controller: self)
        
        // Lancer une nouvelle partie
        self.nouvellePartie()
    }
    
    @IBAction func caseSelectionnee(_ sender: AnyObject) {
        let mouvement = Coordonnees(ligne: sender.selectedRow+1, colonne: sender.selectedColumn+1)
        self.mouvement(mouvement)
    }
    
    @IBAction func recommencer(_ sender: AnyObject) {
        self.nouvellePartie()
    }
    
    @IBAction func changerDifficulte(_ sender: AnyObject) {
        switch difficultePopUpButton.indexOfSelectedItem {
        case 1:
            self.difficulte = Heuristique(controller: self)
        case 2:
            self.difficulte = Minimax(controller: self)
        case 3:
            self.difficulte = AlphaBeta(controller: self)
        case 4:
            self.difficulte = NegaScout(controller: self)
        default:
            self.difficulte = Aleatoire(controller: self)
        }
        
        self.nouvellePartie()
    }
    
    func afficherPlateau() {
        var scoreNoir = 0
        var scoreBlanc = 0
        
        for i in 0..<8 {
            for j in 0..<8 {
                let etatCase = self.plateau.etatCase(i+1, colonne: j+1)
                let cell = self.plateauMatrix.cell(atRow: i, column: j) as! NSButtonCell
                
                // On active la cellule seulement si le mouvement est possible par l'utilisateur
                if self.joueurActuel == NOIR && self.plateau.isMouvementPossible(self.joueurActuel, ligne: i+1, colonne: j+1) {
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
        
        if self.plateau != nil {
            self.plateau.reset()
        }
        else {
            self.plateau = Plateau()
        }
        
        // On attend le prochain mouvement
        self.mouvementSuivant()
    }
    
    func mouvement(_ coordonnees: Coordonnees) {
        self.plateau.mouvement(self.joueurActuel, ligne: coordonnees.ligne, colonne: coordonnees.colonne)
        
        // On change de joueur et on attend le prochain mouvement
        self.changerJoueur()
        self.mouvementSuivant()
    }
    
    func changerJoueur() {
        self.joueurActuel = (self.joueurActuel == BLANC) ? NOIR : BLANC
    }
    
    func mouvementSuivant() {
        // Mise à jour de l'interface graphique
        self.afficherPlateau()
        
        // On récupère les mouvements possibles
        let mouvementsNoir = self.plateau.mouvementsPossibles(NOIR)
        let mouvementsBlanc = self.plateau.mouvementsPossibles(BLANC)
        
        if mouvementsNoir.isEmpty && mouvementsBlanc.isEmpty {
            
            // Fin du jeu, on détermine le gagnant
            if scoreNoirTextField.intValue == scoreBlancTextField.intValue {
                // Egalité
                self.messageTextField.stringValue = "Terminé ! C'est une égalité."
            }
            else if (scoreNoirTextField.intValue > scoreBlancTextField.intValue) {
                // Noir gagne
                self.messageTextField.stringValue = "Terminé ! Victoire des Noirs."
            }
            else {
                // Blanc gagne
                self.messageTextField.stringValue = "Terminé ! Victoire des Blancs."
            }
        }
        else {
            if joueurActuel == BLANC {
                // L'IA est en train de jouer
                self.messageTextField.stringValue = "L'IA est en train de jouer"
                
                queue?.addOperation(BlockOperation {
                    self.difficulte!.calculMouvement(self.plateau)
                    })
            }
            else {
                // À vous de jouer
                self.messageTextField.stringValue = "À vous de jouer"
                
                if mouvementsNoir.isEmpty {
                    self.passer()
                }
            }
        }
    }
    
    func passer() {
        self.changerJoueur()
        self.mouvementSuivant()
    }
}
