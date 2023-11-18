//
//  NetworkManagerTests.swift
//  PokeAPITests
//
//  Created by Kelvin Ofula on 11/18/23.
//

import XCTest
import Combine
@testable import PokeAPI

class NetworkManagerTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchPokemonList() {
        let expectation = XCTestExpectation(description: "Fetch Pokemon List")
        
        NetworkManager.shared.fetchPokemonList()
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertFalse(response.results.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchPokemonDetail() {
        let expectation = XCTestExpectation(description: "Fetch Pokemon Detail")
        
        NetworkManager.shared.fetchPokemonDetail(for: 1)
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
