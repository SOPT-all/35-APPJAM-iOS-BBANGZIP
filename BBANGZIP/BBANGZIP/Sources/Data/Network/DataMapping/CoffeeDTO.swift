//
//  CoffeeDTO.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

struct CoffeeDTO: Decodable {
    let title, description: String
    let ingredients: [String]
    let image: String
    let id: Int
}

extension CoffeeDTO {
    func toDomain() -> CoffeeModel {
        CoffeeModel(
            title: title,
            id: id
        )
    }
}
