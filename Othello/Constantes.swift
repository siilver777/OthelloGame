//
//  Constantes.swift
//  Othello
//
//  Created by Jason Pierna on 26/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

// État des cases
let EMPTY = 0
let BLACK = 1
let WHITE = -1
let BORDER = 3

let CASE_VIDE = 0
let NOIR = 1
let BLANC = -1
let BORD_PLATEAU = 3

// Plateau et déplacements

let PLATEAU_DEPART = [
    BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BLANC,          NOIR,           CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      NOIR,           BLANC,          CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      CASE_VIDE,      BORD_PLATEAU,
    BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU,   BORD_PLATEAU
]

let DIRECTIONS = [
    -11, -10, -9, -1, 1, 9, 10, 11
]

// Stratégies
let TEMPS_PAUSE = 0.2