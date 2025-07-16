//
//  ShapesViewModel.swift
//  CricutProject
//
//  Created by Arpit Mallick on 6/17/25.
//

import Foundation

enum ViewState1 {
    case loading
    case load([ShapeButton])
    case error(String)
}

final class ShapesViewModel: ObservableObject {
    private let networkService: NetworkService
    @Published var viewState = ViewState.loading
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchShapes() async {
        do {
            let response: ShapeModel = try await networkService.fetchData(from: ApiConstants.apiUrl)
             viewState = .load( response.buttons)
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
}
