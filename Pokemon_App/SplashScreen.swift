//
//  SplashScreen.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 07/08/24.
//

import UIKit
import SwiftyGif


class SplashScreen: UIViewController {

    
    @IBOutlet weak var logoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        do {
            let gif = try UIImage(gifName: "Poke_Gif")
            let imageview = UIImageView(gifImage: gif, loopCount: 20) // Will loop 3 times
            imageview.frame = logoImg.frame
            view.addSubview(imageview)
        }
        catch
        {
            print(error)
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 )
        {
            let nextViewcontoller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(nextViewcontoller!, animated: true)
        }
    }
    



}
