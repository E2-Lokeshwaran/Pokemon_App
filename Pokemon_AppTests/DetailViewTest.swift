//
//  DetailViewTest.swift
//  Pokemon_AppTests
//
//  Created by Lokeshwaran on 09/08/24.
//

struct Card {
    let url: String
    // other properties if needed
}


import XCTest
@testable import Pokemon_App

final class DetailViewTest: XCTestCase {
    
    var detailTest : DetailsView!
    
    override func setUp()
    {
        super.setUp()
        detailTest = DetailsView()
        detailTest.loadViewIfNeeded()
    }
    
    override func tearDown()
    {
        detailTest = nil
        super.tearDown()
    }
    
    
//    func testUpdateUi()
//    {
//        let cards = [
//            Pokemon_App.Card(from: "https://pokedex.alansantos.dev/assets/pokemons/cards/019/SM10_EN_143.png" as! Decoder)
//           ]
//        
//        let pokemon = Pokemon(types: ["Normal"], descriptions: ["Will chew on anything with its fangs. If you see one, you can be certain that 40 more live in the area."], name: "Rattata", baseStats: ["defence":35,"hp":30,"attack":56,"total":253,"spDef":35,"speed":72,"spAtk":25], imageUrl: "https://pokedex.alansantos.dev/assets/pokemons/images/019.png", cards: cards)
//        
//        detailTest.updateUI(with: pokemon)
//        
//        XCTAssertEqual(detailTest.PokeName.text, "")
//        XCTAssertEqual(detailTest.PokeType.text,"Type: ")
//        XCTAssertEqual(detailTest.PokeBaseStats.text,"Base Stats:-")
//        XCTAssertEqual(detailTest.PokeDescription.text,"desc:-")
//        XCTAssertEqual(detailTest.cardImageUrls.count, 10)
//        XCTAssertEqual(detailTest.cardImageUrls.first,"card 1 url")
//    }
    
    func testCollectionViewDataSource()
    {
        //need to give all the url
        detailTest.cardImageUrls = ["url1","url2"]

        //no of cards in the collection view
        XCTAssertEqual(detailTest.collectionView(detailTest.collectionView, numberOfItemsInSection: 0), 2)
        
        
    }
    
//    func testFetchImage()
//    {
//        let expectation = self.expectation(description: "Fetch image")
//        let imageUrl = URL(string: "")
//        
//        detailTest.fetchImage(from: imageUrl)
//        {
//            image in
//            XCTAssertNotNil(image)
//            expectation.fulfill()
//        }
//        
//        {
//            image in
//            XCTAssertNotNil(image)
//        }
//    }
    
}
