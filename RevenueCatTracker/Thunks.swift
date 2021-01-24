//
//  Thunks.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift
import ReSwiftThunk

//fileprivate let fetchSearchMoviesPage = Thunk<MainState> { dispatch, getState in
//    guard
//        let state = getState(),
//        !state.moviePages.isComplete,
//        case let .searching(query) = state.search,
//        !query.isEmpty
//    else {
//        return
//    }
//
//    let page = state.moviePages.currentPage + 1
//
////    TMDB().searchMovies(query: query, page: page) { result in
////        guard let result = result else { return }
////
////        DispatchQueue.main.async {
////            dispatch(
////                MainStateAction.fetchNextMoviesPage(
////                    totalPages: result.totalPages,
////                    movies: result.results
////                )
////            )
////        }
////    }
//}
//
//let fetchMoviesPage = Thunk<MainState> { dispatch, getState in
//    guard let state = getState() else { return }
//
//    if case .searching = state.search {
//        dispatch(fetchSearchMoviesPage)
//    } else {
//        dispatch(fetchNextUpcomingMoviesPage)
//    }
//}

let fetchRevenueCat = Thunk<MainState> { dispatch, getState in
//    TMDB().fetchMovieGenres { result in
//        guard let result = result else { return }
//
//        DispatchQueue.main.async {
//            dispatch(
//                MainStateAction.addGenres(result.genres)
//            )
//        }
//    }
}

let loginRevenueCat = Thunk<MainState> { dispatch, getState in
//    TMDB().fetchMovieGenres { result in
//        guard let result = result else { return }
//
//        DispatchQueue.main.async {
//            dispatch(
//                MainStateAction.addGenres(result.genres)
//            )
//        }
//    }
    
    guard let credentials = getState()?.credentials else {
        return
    }
    ApiClient().login(credentials: credentials) { (auth) in
        guard let auth = auth else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.authSuccessfully(auth)
            )
        }
    }
}
