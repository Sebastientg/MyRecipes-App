//
//  RecipesPage.swift
//  Recipes
//
//  Created by Sebastien Tello on 6/18/24.
//

import SwiftUI

/// A view to display a list of recipes with their associated images.
struct RecipesPage: View {
    @EnvironmentObject var recipeManager: RecipeManager  // Accesses the shared recipe manager

    var body: some View {
        List {
            // Iterates over the list of recipes and their images
            ForEach(recipeManager.recipesWithImages, id: \.0.id) { recipe, image in
                Section {
                    VStack(alignment: .leading) {
                        // Displays the recipe title
                        Text(recipe.title)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hue: 0.583, saturation: 1.0, brightness: 0.236))
                        
                        // Displays the recipe ingredients
                        Text("Ingredients: \(recipe.ingredients)")
                            .font(.headline)
                            .padding()
                        
                        // Displays the recipe description
                        Text("Description: \(recipe.description)")
                            .font(.headline)
                            .padding()
                        
                        // Displays the recipe image if available, otherwise a placeholder
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image(systemName: "photo") // Placeholder if no image is available
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .listRowBackground(Color(hue: 0.516, saturation: 0.471, brightness: 0.718)) // Sets the background color for each list row
        }
        .scrollContentBackground(.hidden) // Hides the default list background
        .foregroundColor(Color(hue: 0.583, saturation: 1.0, brightness: 0.236)) // Sets the text color
        .background(Color(red: 0.99, green: 0.98, blue: 0.93)) // Sets the background color
    }
}

#Preview {
    RecipesPage()
        .environmentObject(RecipeManager()) // Provides the recipe manager for preview
}
