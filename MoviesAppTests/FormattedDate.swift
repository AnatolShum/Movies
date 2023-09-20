//
//  FormattedDate.swift
//  MoviesAppTests
//
//  Created by Anatolii Shumov on 13/09/2023.
//

import XCTest
@testable import MoviesApp

final class FormattedDate: XCTestCase {
    var viewModel: MovieItemViewModel!

    override func setUpWithError() throws {
      viewModel = MovieItemViewModel(movie: Movie(
        title: "John Wick: Chapter 4",
        id: 603692,
        backdrop: "/7I6VUdPj6tQECNHdviJkUHD2u89.jpg",
        poster: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
        releaseDate: "2023-03-22",
        overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
        vote: 7.8))
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    func testFormattedDate() throws {
        let formattedDate = viewModel.formattedDate(viewModel.movie.releaseDate)
        XCTAssertFalse(formattedDate.isEmpty)
        XCTAssertEqual(formattedDate, "22 Mar 2023")
    }

}
