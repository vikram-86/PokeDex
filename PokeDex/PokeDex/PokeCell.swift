//
//  PokeCell.swift
//  PokeDex
//
//  Created by Suthananth Arulanatham on 22.11.2015.
//  Copyright © 2015 Suthananth Arulanatham. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    var pokemon : Pokemon!
    
    func configureCell(pokemon : Pokemon){
        self.pokemon = pokemon
        nameLabel.text = pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemon.pokedexID)")
    }
    
}
