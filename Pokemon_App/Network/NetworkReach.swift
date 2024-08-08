//
//  NetworkReach.swift
//  Pokemon_AppTests
//
//  Created by Lokeshwaran on 08/08/24.
//

import UIKit
import Network
import SwiftyGif

class NetworkReach: UIViewController {

    private let monitor = NWPathMonitor()
    private var isMonitoringActive = false
    
    @IBOutlet weak var loadImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMonitoring()
        // Do any additional setup after loading the view.
    }
    
        private func setupMonitoring() {
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    self.updateImageView(isConnected: true)
                } else {
                    self.updateImageView(isConnected: false)
                }
            }
            
            let queue = DispatchQueue(label: "NetworkMonitor")
            monitor.start(queue: queue)
            isMonitoringActive = true
        }
        
        private func updateImageView(isConnected: Bool) {
            DispatchQueue.main.async {
                if isConnected
                {
                    print("Connected")
                }
                else
                {
                    //self.img.image = UIImage(named: "offlin")
                    print("Not Connnected")
                    self.img()
                }
            }
        }
         func showOfflineAlert()
    {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    
    func img()
    {
        do {
            let gif = try UIImage(gifName: "No Internet")
            let imageview = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
            imageview.frame = view.bounds
            view.addSubview(imageview)
        }
        catch
        {
            print(error)
        }
    }


}
