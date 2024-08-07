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
    let cards : [Card]?
    
}

struct Card: Codable {
    let number: String
    let name: String
    let expansionName: String
    let imageUrl: String
}

import UIKit

class DetailsView: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate 
{

    
    @IBOutlet weak var PokeImage: UIImageView!
    @IBOutlet weak var PokeType: UILabel!
    @IBOutlet weak var PokeName: UILabel!
    @IBOutlet weak var PokeBaseStats: UILabel!
    @IBOutlet weak var PokeCard: UILabel!
    @IBOutlet weak var PokeDescription: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coverView: UIView!
    
    
    var urlNumber : String?
    var collectionData : [String] = ["Pokemon_Logo","Pokemon_Logo","Pokemon_Logo","Pokemon_Logo","Pokemon_Logo","Pokemon_Logo"]
    var cardImageUrls : [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        urlNumber = tableNumber
        print("DV ->",tableNumber)
       
        let url = "https://pokedex.alansantos.dev/api/pokemons/" + urlNumber! + ".json"
        print("urls ->",url)
        
        fetchDetails(urlString: url)
        detailView.layer.cornerRadius = 20
        coverView.layer.cornerRadius = 50
    }
    
    //Collection view delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return cardImageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

        let imageUrlString = cardImageUrls[indexPath.item]
        let imageUrl = URL(string: imageUrlString) ?? URL(fileURLWithPath: "")

        fetchImage(from: imageUrl) 
        {
            image in
            DispatchQueue.main.async 
            {
                cell.collectionImage.image = image
            }
        }
    return cell
}
    
    //API method
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
    
    //UI update
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
//        let imageUrlString = pokemon.imageUrl
//        let imageUrl = URL(string: imageUrlString!)
//        fetchImage(from: imageUrl!)
        
        if let imageUrlString = pokemon.imageUrl, let imageUrl = URL(string: imageUrlString)
        {
            fetchImage(from: imageUrl) 
            {
                image in
                DispatchQueue.main.async
                {
                    self.PokeImage.image = image
                }
            }
        }
        
        // Update card image URLs
        self.cardImageUrls = pokemon.cards?.compactMap { $0.imageUrl } ?? []
        self.collectionView.reloadData()
    }
        

    }
    
    //fetch image
//    func fetchImage(from url: URL)
//    {
//        let task = URLSession.shared.dataTask(with: url)
//        {
//            data, response, error in
//            let image = UIImage(data: data!)
//            DispatchQueue.main.async
//            {
//                self.PokeImage.image = image
//            }
//        }
//        task.resume()
//    }
    
    // Fetch image
// Fetch image
func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) 
{
    URLSession.shared.dataTask(with: url) 
    {
        data, response, error in
        guard let data = data, let image = UIImage(data: data) else
        {
            completion(nil)
            return
        }
        completion(image)
    }.resume()
}
    

