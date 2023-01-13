//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Christopher Ching on 2021-02-09.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        
        let featuredRecipes = model.recipes.filter({ $0.featured })
        
        VStack(alignment: .leading, spacing: 0) {
        
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 24))
                
            
            GeometryReader { geo in
            
            TabView (selection: $tabSelectionIndex) {
                
                // Loop through each recipe
                ForEach (0..<featuredRecipes.count) { index in
                    
                    // Recipe card button
                    Button(action: {
                        
                        // Show the recipe detail sheet
                        self.isDetailViewShowing = true
                        
                    }, label: {
                        
                        // Recipe card
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                
                            
                            VStack(spacing: 0) {
                                Image(featuredRecipes[index].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                Text(featuredRecipes[index].name)
                                    .padding(5)
                                    .font(Font.custom("Avenir", size: 15))
                            }
                        }
                        
                    })
                    .tag(index)
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(15)
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
        }
        
            VStack (alignment: .leading, spacing: 10) {
                
                Text("Preparation Time:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                Text(model.recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir", size: 15))
                
                Text("Highlights")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading, .bottom])
        }
        .sheet(isPresented: $isDetailViewShowing) {
            // Show the Recipe Detail View
            RecipeDetailView(recipe: featuredRecipes[tabSelectionIndex])
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
