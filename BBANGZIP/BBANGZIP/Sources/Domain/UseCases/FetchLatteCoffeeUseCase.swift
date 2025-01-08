//
//  FetchLatteCoffeeUseCase.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

protocol FetchLatteCoffeeUseCase {
    
    func execute() async throws -> [CoffeeModel]
    
}

final class DefaultFetchLatteCoffeeUseCase {
    
    private let coffeeRepository: CoffeeRepository

    init(coffeeRepository: CoffeeRepository) {
        self.coffeeRepository = coffeeRepository
    }
    
}

extension DefaultFetchLatteCoffeeUseCase: FetchLatteCoffeeUseCase {
    
    func execute() async throws -> [CoffeeModel] {
        let modelList = try await coffeeRepository.fetchCoffeeList()
        return modelList.filter { coffeeModel in
            coffeeModel.title.lowercased().contains("latte")
        }
    }
    
}
