//
//  Recipe_List_AppApp.swift
//  Recipe List App
//
//  Created by Alexey Li on 4/19/22.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environmentObject(RecipeModel())
        }
    }
}
