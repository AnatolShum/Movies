//
//  CircleVote.swift
//  MoviesAppTests
//
//  Created by Anatolii Shumov on 14/09/2023.
//

import XCTest
@testable import MoviesApp

final class CircleVote: XCTestCase {
    var viewModel: CircleVoteViewModel!

    override func setUpWithError() throws {
       viewModel = CircleVoteViewModel()
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    func testColor() throws {
        for vote in 0...10 {
           let color = viewModel.setColor(with: Double(vote))
            XCTAssertNotEqual(color, .gray)
        }
    
        let purple = viewModel.setColor(with: 2.999)
        XCTAssertEqual(purple, .purple.opacity(0.7))
        
        let red = viewModel.setColor(with: 3.1)
        XCTAssertEqual(red, .red.opacity(0.7))
        
        let orange = viewModel.setColor(with: 5.99)
        XCTAssertEqual(orange, .orange.opacity(0.7))
        
        let yellow = viewModel.setColor(with: 6.5)
        XCTAssertEqual(yellow, .yellow.opacity(0.7))
        
        let green = viewModel.setColor(with: 7.1)
        XCTAssertEqual(green, .green.opacity(0.7))
    }
    
    func testFormattedString() throws {
        let string = viewModel.formattedString(0.700001)
        XCTAssertEqual(string, "0.7")
    }

}
