//
//  RecipesApp.swift
//  Recipes
//
//  Created by Sebastien Tello on 3/24/24.
//

//import SwiftUI
//
//@main
//struct RecipesApp: App {
//    var body: some Scene {
//        WindowGroup {
//            HomePage()
//        }
//    }
//}

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject private var recipeManager = RecipeManager()
    
    var body: some Scene {
        WindowGroup {
            HomePage()
                .environmentObject(recipeManager)
        }
    }
}
