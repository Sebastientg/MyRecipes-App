//
//  Recipe.swift
//  Recipes
//
//  Created by Sebastien Tello on 6/18/24.
//

import SwiftUI
import Foundation

/// A structure to represent a recipe, conforming to Codable and Identifiable protocols.
struct Recipe: Codable, Identifiable {
    var id: UUID = UUID()                   // Unique identifier for each recipe
    let title: String                       // Title of the recipe
    let ingredients: String                 // Ingredients of the recipe
    let description: String                 // Description of the recipe
    let imageName: String                   // Name of the image file associated with the recipe
}
