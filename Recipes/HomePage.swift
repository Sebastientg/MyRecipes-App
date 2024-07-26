//
//  ContentView.swift
//
//  ContentView.swift
//  Recipes
//
//  Created by Sebastien Tello on 3/24/24.
//

import SwiftUI

/// The main view of the Recipes app, which serves as the Home Page.
struct HomePage: View {
    @EnvironmentObject var recipeManager: RecipeManager

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color(red: 0.99, green: 0.98, blue: 0.93)
                    .ignoresSafeArea()
                
                // Foreground rectangle
                Rectangle()
                    .foregroundColor(Color(hue: 0.516, saturation: 0.471, brightness: 0.718))
                    .cornerRadius(40)
                    .frame(width: 325, height: 530)
                    .shadow(radius: 10)
                
                // Content within the rectangle
                VStack {
                    // Home image
                    Image("homeImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(40)
                        .frame(width: 260, height: 260)
                        .rotationEffect(.degrees(90))
                    
                    // Star ratings
                    HStack {
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.leadinghalf.fill")
                    }
                    
                    // Welcome text
                    Text("Welcome Back")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hue: 0.583, saturation: 1.0, brightness: 0.236))
                        .font(.title3)
                        .padding()
                    
                    // Navigation links
                    NavigationLink(destination: RecipeInputPage()) {
                        Text("+ New Recipe")
                    }
                    .padding()
                    .font(.headline)
                    .buttonStyle(.bordered)
                    .controlSize(.regular)
                    .colorMultiply(.black)
                    
                    NavigationLink(destination: RecipesPage()) {
                        Text("Recipes...")
                    }
                    .padding()
                    .font(.headline)
                    .buttonStyle(.bordered)
                    .controlSize(.regular)
                    .colorMultiply(.black)
                }
            }
        }
        .accentColor(Color(hue: 0.516, saturation: 0.471, brightness: 0.718))
    }
}

#Preview {
    HomePage()
        .environmentObject(RecipeManager())
}
