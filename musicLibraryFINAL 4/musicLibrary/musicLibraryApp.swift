//
//  musicLibraryApp.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//

//Programmer: Yeabsera Damte
//Date: 10/24/2024
//Xcode (Version 16.0)
//macOS Sequoia 16.1
//Description: This app is an interactive application, that allows the user to add songs they've heard onto a list.
//The user can add information like the song title, artist, year, genre, location where they heard it, and additional notes.
//In addition, they can select the heart button and add it to a seperate list on their favorites tab if they liked the song.
//References: ChatGPT for debugging and modifying algorithm design and Xcode documentation for configurations

import SwiftUI

@main
struct MusicVaultApp: App {
    let persistenceController = PersistenceController.shared
/*
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Set global beige background
                Color(red: 255 / 255, green: 229 / 255, blue: 180 / 255) // Beige color
                    .ignoresSafeArea()

                TabView {
                    LibraryView()
                        .tabItem {
                            Label("Library", systemImage: "music.note.list")
                        }
                    FavoritesView()
                        .tabItem {
                            Label("Favorites", systemImage: "heart.fill")
                        }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
 */
    var body: some Scene {
            WindowGroup {
                
                TabView {
                    LibraryView()
                        .tabItem {
                            Label("Library", systemImage: "music.note.list")
                        }
                    FavoritesView()
                        .tabItem {
                            Label("Favorites", systemImage: "heart.fill")
                        }
                }
                //.background(Color.gray) // Add a solid grey background
                .background(Color.gray.opacity(0.9))
                .ignoresSafeArea() // Make the background extend to the edges
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
}

