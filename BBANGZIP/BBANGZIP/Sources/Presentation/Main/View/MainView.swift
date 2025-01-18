//
//  MainView.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: TestView()) {
                    Text("Go to TestView")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .navigationTitle("Main View")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
