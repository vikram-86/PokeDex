//
//  ViewController.swift
//  PokeDex
//
//  Created by Suthananth Arulanatham on 22.11.2015.
//  Copyright © 2015 Suthananth Arulanatham. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    @IBOutlet weak var collection : UICollectionView!
    var pokemon = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    @IBOutlet weak var searchBar: UISearchBar!
    var isInSearchMode = false
    var filteredPokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        initAudio()
        parsePokemonCSV()
    }
    
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                guard let pokeID = Int(row["id"]!) else{
                    return
                }
                guard let name = row["identifier"] else{
                    return
                }
                
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemon.append(poke)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            let pokemon: Pokemon!
            if isInSearchMode {
                pokemon = filteredPokemons[indexPath.row]
            }else{
                pokemon = self.pokemon[indexPath.row]
            }
            cell.configureCell(pokemon)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var poke : Pokemon!
        if isInSearchMode{
            poke = filteredPokemons[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
        performSegueWithIdentifier("PokemonDetail", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInSearchMode ? filteredPokemons.count : pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }

    @IBAction func audioButtonPressed(sender: UIButton) {
        if musicPlayer.playing {
            sender.setImage(UIImage(named:"sound"), forState: .Normal)
            musicPlayer.stop()
        }else{
            sender.setImage(UIImage(named:"no_sound"), forState: .Normal)
            musicPlayer.play()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        }else{
            isInSearchMode = true
            let searchText = searchBar.text!.lowercaseString
            filteredPokemons = pokemon.filter({$0.name.rangeOfString(searchText) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetail" {
            if let detailVC = segue.destinationViewController as? PokemonDetailViewController {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }

}

