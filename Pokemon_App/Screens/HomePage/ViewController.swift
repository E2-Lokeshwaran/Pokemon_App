//
//  ViewController.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 05/08/24.
//


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

var tableNumber = ""


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
{
 
    var indPath = 0
    
    var searchData : [WelcomeElement]?
    var jsonData : [WelcomeElement]?


    @IBOutlet weak var Searchbar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        ApiData()
////        
////        guard Searchbar != nil else 
////        {
////            fatalError("Searchbar outlet is not connecteddddd")
////        }
//        Searchbar.delegate = self
//        
//        self.navigationItem.hidesBackButton = true
//
//        // Set up a tap gesture recognizer to dismiss the keyboard
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad started")
        
        // Check if view is loaded
        if isViewLoaded {
            print("View is loaded")
        } else {
            print("View is not loaded")
        }
        
        // Check Searchbar
        if let searchBar = Searchbar {
            print("Searchbar is connected")
            searchBar.delegate = self
        } else {
            print("Error: Searchbar is nil")
        }
        
        // Check TableView
        if let tableView = TableView {
            print("TableView is connected")
        } else {
            print("Error: TableView is nil")
        }
        
        ApiData()
        
        self.navigationItem.hidesBackButton = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        print("ViewDidLoad completed")
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }

    //TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return searchData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.PokemonType.text = searchData?[indexPath.row].name
        
        let urlString = searchData![indexPath.row].imageURL
        let url = URL(string: urlString)!
        

            DispatchQueue.global().async 
            {
                let data = try? Data(contentsOf: url)
                let loadimg = UIImage(data: data!)
                DispatchQueue.main.async 
                {
                    cell.PokemonImage.image = loadimg
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
        tableNumber = (searchData?[indexPath.row].number)!
        print("dumpurl-->",tableNumber)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsView") as? DetailsView
        {
            detailsVC.urlNumber = tableNumber
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    
    //SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) 
    {
        if searchText.isEmpty
        {
            searchData = jsonData
        }
        else
        {
            searchData = jsonData?.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        TableView.reloadData()
        
    }
    
    // Dismiss keyboard when the search bar's "Search" button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) 
    {
        searchBar.resignFirstResponder()
    }

    // Make sure the keyboard appears when starting to type in the search bar
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        return true
    }
    
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
                    self.jsonData = content
                    self.searchData = content
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

