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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon : Pokemon){
        self.pokemon = pokemon
        nameLabel.text = pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemon.pokedexID)")
    }
    
}
