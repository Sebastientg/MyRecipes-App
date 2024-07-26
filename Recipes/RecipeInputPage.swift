//
//  ContentViewRecipeInput.swift
//  Recipes
//
//  Created by Sebastien Tello on 3/28/24.
//

import SwiftUI
import PhotosUI

/// The view for inputting new recipes.
struct RecipeInputPage: View {
    /// A structure to hold the recipe information.
    struct RecipeInfo {
        var recipeTitle: String = ""
        var ingredients: String = ""
        var description: String = ""
    }
    
    @State private var info: RecipeInfo = .init()
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.99, green: 0.98, blue: 0.93)
                .ignoresSafeArea()
            
            VStack {
                // Image picker
                PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                
                Spacer()
                
                // Recipe title input
                recipeTitleView
                    .padding()
                    .border(Color(hue: 0.516, saturation: 0.471, brightness: 0.718), width: 7)
                    .cornerRadius(10)
                    .lineLimit(2, reservesSpace: true)
                    .frame(width: 375)
    
                // Ingredients input
                ingredientView
                    .padding()
                    .border(Color(hue: 0.516, saturation: 0.471, brightness: 0.718), width: 7)
                    .cornerRadius(10)
                    .lineLimit(10, reservesSpace: true)
                    .frame(width: 375)
            
                // Description input
                desciptView
                    .padding()
                    .border(Color(hue: 0.516, saturation: 0.471, brightness: 0.718), width: 7)
                    .cornerRadius(10)
                    .lineLimit(10, reservesSpace: true)
                    .frame(width: 375)
                
                // Create button
                Button("Create") {
                    if let selectedImageData = selectedImageData {
                        // Save the image to the file system and use its file name
                        let imageName = saveImageToFileSystem(imageData: selectedImageData)
                        recipeManager.addRecipe(
                            title: info.recipeTitle,
                            ingredients: info.ingredients,
                            description: info.description,
                            imageName: imageName
                        )
                    } else {
                        // Handle case where no image is selected (optional)
                        recipeManager.addRecipe(
                            title: info.recipeTitle,
                            ingredients: info.ingredients,
                            description: info.description,
                            imageName: "defaultImage" // Provide a default image name
                        )
                    }
                }
                .padding()
                .font(.title)
                .buttonStyle(.bordered)
                .controlSize(.regular)
            }
            .onChange(of: pickerItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
}

private extension RecipeInputPage {
    var recipeTitleView: some View {
        TextField("Recipe Title",
                  text: $info.recipeTitle,
                  prompt: Text("Recipe Title"),
                  axis: .vertical)
    }

    var ingredientView: some View {
        TextField("Ingredients",
                  text: $info.ingredients,
                  prompt: Text("Ingredients"),
                  axis: .vertical)
    }
    
    var desciptView: some View {
        TextField("Description",
                  text: $info.description,
                  prompt: Text("Description"),
                  axis: .vertical)
    }

    /// Save the image to the file system and return its file name.
    /// - Parameter imageData: The data of the image to save.
    /// - Returns: The file name of the saved image.
    func saveImageToFileSystem(imageData: Data) -> String {
        let fileName = UUID().uuidString + ".jpg"
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: fileURL)
            return fileName
        } catch {
            print("Error saving image: \(error)")
            return "defaultImage"
        }
    }
}

#Preview {
    RecipeInputPage()
        .environmentObject(RecipeManager())
}
