//
//  MainViewModel.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    
    private let fetchSortedCoffeeUseCase: FetchLatteCoffeeUseCase
    @Published var coffees: [CoffeeModel] = []
    
    init(useCase: FetchLatteCoffeeUseCase) {
        self.fetchSortedCoffeeUseCase = useCase
    }
    
    func asyncFetchData() async {
        do {
            let modelList = try await fetchSortedCoffeeUseCase.execute()
            Task { @MainActor in
                self.coffees = modelList
            }
        } catch {
            // TODO: error 처리
            dump(error)
        }
    }
    
}
