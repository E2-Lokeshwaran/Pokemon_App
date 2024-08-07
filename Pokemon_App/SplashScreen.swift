//
//  SplashScreen.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 07/08/24.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 )
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    



}
