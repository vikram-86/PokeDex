//
//  Pokemon.swift
//  PokeDex
//
//  Created by Suthananth Arulanatham on 22.11.2015.
//  Copyright © 2015 Suthananth Arulanatham. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    
    var name : String {
        return _name
    }
    
    var pokedexID : Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId : Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}