//
//  CoffeeRepository.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

protocol CoffeeRepository {
    
    func fetchCoffeeList() async throws -> [CoffeeModel]
    
}
