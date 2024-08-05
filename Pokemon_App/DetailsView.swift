//
//  DetailsView.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 05/08/24.
//


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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func ApiDataP()
    {
        let url = URL(string: "https://pokedex.alansantos.dev/api/pokemons/" + urlNum! + ".json")
        let sessions = URLSession.shared.dataTask(with: url!)
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
