//
//  ContentView.swift
//  Memoquest
//
//  Created by roger_jove on 7/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showHelp = false
    
    var body: some View {
        MenuView()
            .overlay(alignment: .topTrailing) {
                Button(action: { showHelp = true }) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .sheet(isPresented: $showHelp) {
                GameHelpView()
            }
    }
}

#Preview {
    ContentView()
}
