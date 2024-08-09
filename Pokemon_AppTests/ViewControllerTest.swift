//
//  ViewControllerTest.swift
//  Pokemon_AppTests
//
//  Created by Lokeshwaran on 08/08/24.
//


//Test Case for --------- ViewController(Home page) ------------------

import XCTest
@testable import Pokemon_App

final class ViewControllerTest: XCTestCase 
{
    var vc : ViewController!
    
    override func setUp() 
    {
        super.setUp()
        vc = ViewController()
        vc.loadViewIfNeeded()
    }
    
    override func tearDown()
    {
        vc = nil
        super.tearDown()
    }
    
    func testViewDidLoad()
    {
        vc = ViewController()
        //vc.viewDidLoad()
        
        vc.loadViewIfNeeded()
        
        
        //XCTAssertNotNil(vc.Searchbar, "Searchbar should not be nil")
        XCTAssertNil(vc.TableView, "TableView should be nil")
        XCTAssertTrue(vc.navigationItem.hidesBackButton, "hidesBackButton should be true")
        
        
//        XCTAssertNotNil(vc.Searchbar)
//        XCTAssertNil(vc.TableView)
//        XCTAssertEqual(vc.navigationItem.hidesBackButton, true)
    }
    
    func testTableViewDataSource()
    {
        vc.ApiData()
        
        let numRows = vc.tableView(vc.TableView, numberOfRowsInSection: 0)
        let cell = vc.tableView(vc.TableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TableViewCell
        
        XCTAssertGreaterThan(numRows, 0)
        XCTAssertNotNil(cell.PokemonImage)
        XCTAssertNotNil(cell.PokemonType)
    }
    
//    func testSearchBar()
//    {
//        vc.ApiData()
//        
//        vc.searchBar(vc.Searchbar, textDidChange: "Bulbasaur")
//        
//        
//        XCTAssertNotNil(vc.searchData)
//        XCTAssertEqual(vc.searchData?.count, 1)
//        XCTAssertEqual(vc.searchData?.first?.name, "Bulbasaur")
//        
//    }

//    func testSearchBar() {
//        // Ensure the view is loaded
//        _ = vc.view
//        
//        // Check if Searchbar is nil and create it if necessary
//        if vc.Searchbar == nil {
//            vc.Searchbar = UISearchBar()
//        }
//        
//        // Ensure searchData is initialized
//        vc.searchData = []
//        
//        // Mock the API data
//        vc.jsonData = [
//            WelcomeElement(number: "001", name: "Bulbasaur", imageURL: "", thumbnailURL: "", sprites: Sprites(from: "" as! Decoder), types: [], specie: "", generation: .generationI)
//            
//        ]
//        
//        // Call the search method
//        vc.searchBar(vc.Searchbar!, textDidChange: "Bulbasaur")
//        
//        // Assertions
//        XCTAssertNotNil(vc.searchData)
//        XCTAssertEqual(vc.searchData?.count, 1)
//        XCTAssertEqual(vc.searchData?.first?.name, "Bulbasaur")
//    }

}
