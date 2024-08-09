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

//        do {
//            let gif = try UIImage(gifName: "Poke_Gif")
//            let imageview = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
//            imageview.frame = logoImg.bounds
//            logoImg.addSubview(imageview)
//        } catch {
//            print(error)
//        }
        
        if let logoImg = logoImg {
            do {
                if let gif = try? UIImage(gifName: "Poke_Main_logo") {
                    let imageView = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
                    imageView.frame = logoImg.bounds
                    logoImg.addSubview(imageView)
                } else {
                    print("Failed to load GIF image")
                }
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("logoImg is nil")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 )
        {
            let nextViewcontoller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(nextViewcontoller!, animated: true)
        }
    }
}
