//
//  ViewControllerTest.swift
//  Pokemon_AppTests
//
//  Created by Lokeshwaran on 08/08/24.
//


//Test Case for -- ViewController(Home page)

import XCTest
@testable import Pokemon_App

final class ViewControllerTest: XCTestCase 
{
    var vc : ViewController!
    
    override func setUp() {
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
        vc.viewDidLoad()
        
        XCTAssertNotNil(vc.Searchbar)
        XCTAssertNil(vc.TableView)
        XCTAssertEqual(vc.navigationItem.hidesBackButton, true)
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
    
    func testSearchBar()
    {
        vc.ApiData()
        
        vc.searchBar(vc.Searchbar, textDidChange: "Bulbasaur")
        
        
        XCTAssertNotNil(vc.searchData)
        XCTAssertEqual(vc.searchData?.count, 1)
        XCTAssertEqual(vc.searchData?.first?.name, "Bulbasaur")
        
    }


}
