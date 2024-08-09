//
//  Pokemon_AppTests.swift
//  Pokemon_AppTests
//
//  Created by Lokeshwaran on 05/08/24.
//


// Test Case for -------SplashScreen-----------

import XCTest
import UIKit
import SwiftyGif
@testable import Pokemon_App

final class Pokemon_AppTests: XCTestCase {
    
    var splashScreen : SplashScreen!
    
    override func setUp()
    {
        super.setUp()
        splashScreen = SplashScreen()
    }
    
    override func tearDown()
    {
        splashScreen = nil
        super.tearDown()
    }
    
    func testViewDidLoad()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        splashScreen = storyboard.instantiateViewController(withIdentifier: "SplashScreen") as? SplashScreen
        splashScreen.loadViewIfNeeded()
        
        splashScreen.viewDidLoad()
        
        XCTAssertNotNil(splashScreen.logoImg)
    }
    
//    func testNavigateToMainPage()
//    {
//        //Given
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        splashScreen = storyboard.instantiateViewController(withIdentifier: "SplashScreen") as? SplashScreen
//        splashScreen.loadViewIfNeeded()
//        
//        //When
//        splashScreen.viewDidLoad()
//        RunLoop.current.run(until: Date(timeIntervalSinceNow: 5))
//        
//        // Then
//        if let navigationController = splashScreen.navigationController 
//        {
//            let mainViewController = navigationController.topViewController as? ViewController
//            XCTAssertNotNil(mainViewController)
//        } 
//        else
//        {
//            XCTFail("SplashScreen's navigationController is nillllll")
//        }
//    }
    
    func testSplashScreenNavigatesToViewController() 
    {
        // Given
        let navigationController = UINavigationController(rootViewController: splashScreen)

        // When
        splashScreen.viewDidLoad()

        // Simulate the passage of 3 seconds
        let expectation = XCTestExpectation(description: "Wait for navigation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        // Then
        let mainViewController = navigationController.topViewController as? ViewController
        XCTAssertNotNil(mainViewController, "Expected to navigate to ViewController but did not.")
    }
    

}
