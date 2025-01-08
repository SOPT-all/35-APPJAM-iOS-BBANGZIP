//
//  MainView.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            List(viewModel.coffees, id: \.id) {
                Text($0.title)
            }
            .onAppear(perform: {
                Task {
                    await viewModel.asyncFetchData()
                }
            })
        }
    }
    
}

#Preview {
    MainView(
        viewModel: MainViewModel(
            useCase: DefaultFetchLatteCoffeeUseCase(
                coffeeRepository: DefaultCoffeeRepository()
            )
        )
    )
}
