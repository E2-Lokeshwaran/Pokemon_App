//
//  CheckNetwork.swift
//  Pokemon_App
//
//  Created by Lokeshwaran on 08/08/24.
//

//import Network
//import UIKit
//
//class CheckNetwork {
//    static let shared = CheckNetwork()
//    
//    private let monitor = NWPathMonitor()
//    private var isMonitoring = false
//    
//    private init() {}
//    
//    func startMonitoring() {
//        if !isMonitoring {
//            monitor.pathUpdateHandler = { path in
//                if path.status == .satisfied {
//                    self.dismissNoInternetView()
//                } else {
//                    self.showNoInternetView()
//                }
//            }
//            
//            let queue = DispatchQueue(label: "NetworkMonitor")
//            monitor.start(queue: queue)
//            isMonitoring = true
//        }
//    }
//    
//    func stopMonitoring() {
//        if isMonitoring {
//            monitor.cancel()
//            isMonitoring = false
//        }
//    }
//    
//    private func showNoInternetView() {
//        DispatchQueue.main.async {
//            guard let topViewController = UIApplication.shared.topMostViewController() else {
//                return
//            }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let noInternetVC = storyboard.instantiateViewController(withIdentifier: "NoNet") as? NoNet {
//                noInternetVC.modalTransitionStyle = .crossDissolve
//                noInternetVC.modalPresentationStyle = .fullScreen
//                topViewController.present(noInternetVC, animated: true, completion: nil)
//            }
//        }
//    }
//    
//    private func dismissNoInternetView() {
//        DispatchQueue.main.async {
//            guard let topViewController = UIApplication.shared.topMostViewController() else {
//                return
//            }
//            if topViewController is NoNet {
//                topViewController.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//}

