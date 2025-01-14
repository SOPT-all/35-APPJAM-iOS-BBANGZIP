//
//  MainView.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MenuView()
                .tabItem {
                    Image(systemName: "cup.and.saucer.fill")
                    Text("Menu")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Welcome to the Coffee App!")
                .font(.headline)
                .navigationTitle("Home")
        }
    }
}

struct MenuView: View {
    var body: some View {
        NavigationView {
            Text("Explore our menu here.")
                .font(.headline)
                .navigationTitle("Menu")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Text("Your profile information.")
                .font(.headline)
                .navigationTitle("Profile")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
