//
//  ContentView.swift
//  Memoquest
//
//  Created by roger_jove on 7/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MenuView()
                .tabItem {
                    Label("Jugar", systemImage: "gamecontroller.fill")
                }
                .tag(0)
            
            GameHelpView()
                .tabItem {
                    Label("Ayuda", systemImage: "questionmark.circle.fill")
                }
                .tag(1)
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
