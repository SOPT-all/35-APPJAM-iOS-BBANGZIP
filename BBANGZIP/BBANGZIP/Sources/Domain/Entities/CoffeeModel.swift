//
//  CoffeeModel.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

// SwiftUI List에서 사용하기 위해 Identifiable채택, Test를 위한 Equatable 채택
struct CoffeeModel: Identifiable, Equatable {
    
    let title: String
    let id: Int
    
}

extension CoffeeModel {
    
    static let mockAll: [CoffeeModel] = [
        CoffeeModel(
            title: "Latte1",
            id: 0
        ),
        CoffeeModel(
            title: "Latte2",
            id: 1
        ),
        CoffeeModel(
            title: "Coffee1",
            id: 2
        ),
        CoffeeModel(
            title: "Latte3",
            id: 3
        )
    ]
    
    static let mockLatte: [CoffeeModel] = [
        CoffeeModel(
            title: "Latte1",
            id: 0
        ),
        CoffeeModel(
            title: "Latte2",
            id: 1
        ),
        CoffeeModel(
            title: "Latte3",
            id: 3
        )
    ]
    
}
