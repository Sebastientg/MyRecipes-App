//
//  RecipeManager.swift
//  Recipes
//
//  Created by Sebastien Tello on 6/18/24.
//

import SwiftUI
import Foundation

/// Manages a collection of recipes and handles saving and loading them from persistent storage.
class RecipeManager: ObservableObject {
    /// An array of recipes, published to update views when changed.
    @Published var recipes: [Recipe] = [] {
        didSet {
            saveRecipes()
        }
    }

    /// The key used for saving recipes to UserDefaults.
    private let recipesKey = "recipes"

    /// Initializes the recipe manager and loads saved recipes.
    init() {
        loadRecipes()
    }

    /// Adds a new recipe to the collection.
    /// - Parameters:
    ///   - title: The title of the recipe.
    ///   - ingredients: The ingredients of the recipe.
    ///   - description: The description of the recipe.
    ///   - imageName: The name of the image associated with the recipe.
    func addRecipe(title: String, ingredients: String, description: String, imageName: String) {
        let recipe = Recipe(title: title, ingredients: ingredients, description: description, imageName: imageName)
        recipes.append(recipe)
    }

    /// Returns an array of tuples containing recipes and their associated images.
    var recipesWithImages: [(Recipe, UIImage?)] {
        return recipes.map { recipe in
            let image = loadImage(named: recipe.imageName)
            return (recipe, image)
        }
    }

    /// Saves the current recipes to UserDefaults.
    private func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: recipesKey)
        }
    }

    /// Loads recipes from UserDefaults.
    private func loadRecipes() {
        if let savedRecipes = UserDefaults.standard.data(forKey: recipesKey),
           let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedRecipes) {
            recipes = decodedRecipes
        }
    }

    /// Loads an image from the file system.
    /// - Parameter imageName: The name of the image file.
    /// - Returns: A UIImage if the image was successfully loaded, otherwise nil.
    private func loadImage(named imageName: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error)")
            return nil
        }
    }
}
