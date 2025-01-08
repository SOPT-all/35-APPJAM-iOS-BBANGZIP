//
//  DefaultCoffeeRepository.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

import Alamofire

final class DefaultCoffeeRepository: CoffeeRepository {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func fetchCoffeeList() async throws -> [CoffeeModel] {
        do {
            // TODO: BaseURL xcconfig 파일로 숨기기,
            // TODO: request 매개변수 Network 계층화
            let data = try await session.request(
                "https://api.sampleapis.com/coffee/hot",
                method: .get
            )
            .serializingDecodable([CoffeeDTO].self).value
            
            let domainModels = data.map { $0.toDomain() }
            return domainModels
        } catch {
            // Alamofire 혹은 다른 곳에서 발생한 error를 catch를 통해 커스텀한 error로 매핑할 수 있음
            throw RepositoryError.exampleError
        }
    }
    
}
