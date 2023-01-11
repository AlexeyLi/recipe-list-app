//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Alexey Li on 11/17/22.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(.largeTitle)
            
            GeometryReader { geo in
                
                TabView {
                    
                    // Loop through each recipe
                    ForEach(0..<model.recipes.count) { index in
                        
                        var recipe = model.recipes[index]
                        
                        // Only show those that should be featured
                        if (recipe.featured) {
                            
                            Button(action: {
                                
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                                
                            }, label: {
                                // Recipe card
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    VStack {
                                        Image(recipe.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(recipe.name)
                                            .padding(5)
                                    }
                                }
                            })
                            .sheet(isPresented: $isDetailViewShowing) {
                                // Show the Recipe Detail View
                                RecipeDetailView(recipe: recipe)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                                .cornerRadius(15)
                                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Preparation Time:")
                    .font(.headline)
                Text("1 hour")
                Text("Highlights")
                    .font(.headline)
                Text("Healthy, Hearty")
            }
            .padding([.leading, .bottom])
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
