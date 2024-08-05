//
//  ViewController.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 05/08/24.
//

//struct Mydata : Codable
//{
//    let name : String?
//    let imageUrl : String?
//}


struct WelcomeElement: Codable {
    let number, name: String
    let imageURL, thumbnailURL: String
    let sprites: Sprites
    let types: [TypeElement]
    let specie: String
    let generation: Generation

    enum CodingKeys: String, CodingKey {
        case number, name
        case imageURL = "imageUrl"
        case thumbnailURL = "thumbnailUrl"
        case sprites, types, specie, generation
    }
}

enum Generation: String, Codable {
    case generationI = "GENERATION_I"
    case generationIi = "GENERATION_II"
    case generationIii = "GENERATION_III"
    case generationIv = "GENERATION_IV"
    case generationV = "GENERATION_V"
    case generationVi = "GENERATION_VI"
    case generationVii = "GENERATION_VII"
    case generationViii = "GENERATION_VIII"
}

// MARK: - Sprites
struct Sprites: Codable {
    let mainSpriteURL: String
    let frontAnimatedSpriteURL, backAnimatedSpriteURL, frontShinyAnimatedSpriteURL, backShinyAnimatedSpriteURL: String?

    enum CodingKeys: String, CodingKey {
        case mainSpriteURL = "mainSpriteUrl"
        case frontAnimatedSpriteURL = "frontAnimatedSpriteUrl"
        case backAnimatedSpriteURL = "backAnimatedSpriteUrl"
        case frontShinyAnimatedSpriteURL = "frontShinyAnimatedSpriteUrl"
        case backShinyAnimatedSpriteURL = "backShinyAnimatedSpriteUrl"
    }
}

enum TypeElement: String, Codable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case normal = "Normal"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case water = "Water"
}


import UIKit

var dumpNum = ""
var nameData : [String]!

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
{

    var indPath = 0
    
    var searchData : [String]!
    var json : [WelcomeElement]?
    
   


    @IBOutlet weak var Searchbar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ApiData()
    }


    //TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return json?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.PokemonType.text = json?[indexPath.row].name
        
        if let urlString = json?[indexPath.row].imageURL, let url = URL(string: urlString)
        {
            DispatchQueue.global().async 
            {
                if let data = try? Data(contentsOf: url), let loadimg = UIImage(data: data) {
                    DispatchQueue.main.async
                    {
                        cell.PokemonImage.image = loadimg
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        indPath = indexPath.row
        dumpNum = (json?[indexPath.row].number)!
        print("dumpurl-->",dumpNum)
    }
    
    //SearchBar

    
    
    
    
    
    //API
    func ApiData()
    {
        let url = URL(string:"https://pokedex.alansantos.dev/api/pokemons.json")
        let session = URLSession.shared.dataTask(with: url!)
        {
            (data,response,error) in
                do
                {
                    let content = try? JSONDecoder().decode([WelcomeElement].self ,from: data!)
                    self.json = content
                    DispatchQueue.main.async
                    {
                    self.TableView.reloadData()
                    }
                }
                catch
                {
                    print("Error data")
                }
            }
            session.resume()
        }
}

