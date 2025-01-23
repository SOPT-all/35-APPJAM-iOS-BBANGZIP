import SwiftUI

public struct ContentView: View {
    @State private var showMainView = false
    
    public var body: some View {
        ZStack {
            if showMainView {
                LoginView()
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
