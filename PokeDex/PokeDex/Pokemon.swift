//
//  Pokemon.swift
//  PokeDex
//
//  Created by Suthananth Arulanatham on 22.11.2015.
//  Copyright © 2015 Suthananth Arulanatham. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defence : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvolutionText : String!
    private var _pokemonURL : String!
    
    var name : String {
        return _name
    }
    
    var pokedexID : Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId : Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexID)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: self._pokemonURL)!
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defence = dict["defense"] as? Int {
                    self._defence = "\(defence)"
                }
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    if var name = types[0]["name"]?.capitalizedString{
                        for var x = 1; x < types.count; x++ {
                            name = "\(name)/\(types[x]["name"]!.capitalizedString)"
                        }
                        print(name)
                    }
                    
                }
            }
            
        }
    }
}