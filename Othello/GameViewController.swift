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
    
    var plateau: Plateau!
    var joueurActuel: Int!
    var difficulte: Strategie?
    var queue: NSOperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nouvellePartie()
    }
    
    @IBAction func caseSelectionnee(sender: AnyObject) {
        let mouvement = Coordonnees(ligne: sender.selectedRow+1, colonne: sender.selectedColumn+1)
        self.mouvement(mouvement)
    }
    
    /*@IBAction func lancerNouvellePartie(sender: AnyObject) {
        self.nouvellePartie()
    }*/
    
    /*@IBAction func passerTour(sender: AnyObject) {
        
    }*/
    
    func afficherPlateau() {
        var scoreNoir = 0
        var scoreBlanc = 0
        
        for i in 0..<8 {
            for j in 0..<8 {
                let etatCase = self.plateau.etatCase(i+1, colonne: j+1)
                let cell = self.plateauMatrix.cellAtRow(i, column: j) as! NSButtonCell
                
                // On active la cellule seulement si le mouvement est possible par l'utilisateur
                if self.joueurActuel == NOIR && self.plateau.isMouvementPossible(self.joueurActuel, ligne: i+1, colonne: j+1) {
                    cell.enabled = true
                }
                else {
                    cell.enabled = false
                }
                
                switch(etatCase) {
                case BLACK:
                    cell.image = NSImage(named: "blackpiece")
                    scoreNoir += 1
                case WHITE:
                    cell.image = NSImage(named: "whitepiece")
                    scoreBlanc += 1
                case EMPTY:
                    cell.image = nil
                default:
                    print("Case jouable")
                    cell.image = NSImage(named: "jouable")
                }
            }
        }
        
        scoreNoirTextField.stringValue = "\(scoreNoir)"
        scoreBlancTextField.stringValue = "\(scoreBlanc)"
    }
    
    func nouvellePartie() {
        // Le joueur commence
        joueurActuel = NOIR
        
        /* Lignes démarrant l'IA à ajouter */
        
        if (queue != nil) {
            queue?.cancelAllOperations()
        }
        else {
            queue = NSOperationQueue()
        }
        
        self.difficulte = Aleatoire(controller: self, player: WHITE)
        
        if self.plateau != nil {
            self.plateau.reset()
        }
        else {
            self.plateau = Plateau()
        }
        
        // On attend le prochain mouvement
        self.mouvementSuivant()
    }
    
    func mouvement(coordonnees: Coordonnees) {
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
                print("Egalite")
            }
            else if (scoreNoirTextField.intValue > scoreBlancTextField.intValue) {
                // Noir gagne
                print("Noir")
            }
            else {
                // Blanc gagne
                print("blanc")
            }
            
            // Remise en place des boutons, etc ……
            
        }
        else {
            if joueurActuel == BLANC {
                // L'IA est en train de jouer
                print("L'IA est en train de jouer")
                
                queue?.addOperation(NSBlockOperation {
                    self.difficulte?.calculMouvement(self.plateau)
                    })
            }
            else {
                // À vous de jouer
                print("À vous de jouer")
            }
        }
    }
    
    func passer() {
        self.changerJoueur()
        self.mouvementSuivant()
    }
}
