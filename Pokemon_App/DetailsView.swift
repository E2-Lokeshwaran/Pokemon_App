//
//  DetailsView.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 05/08/24.
//

struct Pokemon: Codable
{
    let types: [String]?
    let descriptions: [String]?
    let name: String?
    let baseStats: [String: Int]?
    let imageUrl: String?
}

import UIKit

class DetailsView: UIViewController {

        
    @IBOutlet weak var PokeImage: UIImageView!
    @IBOutlet weak var PokeType: UILabel!
    @IBOutlet weak var PokeName: UILabel!
    @IBOutlet weak var PokeBaseStats: UILabel!
    @IBOutlet weak var PokeCard: UILabel!
    @IBOutlet weak var PokeDescription: UILabel!
    
    
    var urlNum : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        urlNum = dumpNum
        print("DV ->",dumpNum)
        
       
        let url = "https://pokedex.alansantos.dev/api/pokemons/" + urlNum! + ".json"
        print("urls ->",url)
        
        fetchDetails(urlString: url)
    }
    
    
    func fetchDetails(urlString: String)
    {
        let url = URL(string: urlString)
        let session = URLSession.shared.dataTask(with: url!)
        {
            (data,response,error)in
            do
            {
                let content = try JSONDecoder().decode(Pokemon.self, from: data!)
                DispatchQueue.main.async
                {
                    self.updateUI(with: content)
                }
            }
            catch
            {
                print("Error data -->", error)
            }
        }
        session.resume()
    }
    
    func updateUI(with pokemon: Pokemon)
    {
        //name
        self.PokeName.text = pokemon.name
        print("Mayday name-->",pokemon.name!)
        
        //type
        self.PokeType.text = "Type: \(pokemon.types?.joined(separator: ", ") ?? "")"
        print("Mayday types -->", pokemon.types?.joined(separator: ", ") ?? "")
        
        //base stat
        self.PokeBaseStats.text = "Base Stats:\n\(pokemon.baseStats?.map { "\($0.key): \($0.value)" }.joined(separator: "\n") ?? "")"
        print("Mayday Base stat -->", pokemon.baseStats?.map { "\($0.key): \($0.value)" }.joined(separator: "\n") ?? "")
        
        //description
        self.PokeDescription.text = pokemon.descriptions?.joined(separator: "\n\n") ?? ""
        print("Mayday Desc -->", pokemon.descriptions?.joined(separator: "\n\n") ?? "")
        
        //image
        let imageUrlString = pokemon.imageUrl
        let imageUrl = URL(string: imageUrlString!)
        fetchImage(from: imageUrl!)
    }
    
    
    func fetchImage(from url: URL)
    {
        let task = URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            let image = UIImage(data: data!)
            DispatchQueue.main.async
            {
                self.PokeImage.image = image
            }
        }
        task.resume()
    }
    
}
