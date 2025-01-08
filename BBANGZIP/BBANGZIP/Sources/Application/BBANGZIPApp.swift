import SwiftUI

@main
struct BBANGZIPApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                viewModel: MainViewModel(
                    useCase: DefaultFetchLatteCoffeeUseCase(
                        coffeeRepository: DefaultCoffeeRepository()
                    )
                )
            )
        }
    }
}
