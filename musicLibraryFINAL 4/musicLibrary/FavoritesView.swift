//
//  FavoritesView.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//



import SwiftUI


struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = MusicVaultViewModel(context: PersistenceController.shared.container.viewContext)

    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("Image") // Replace "Image" with your actual image name
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all) // Ensures it fills the entire screen

                // Content with adjusted alignment
                VStack(alignment: .leading) { // Align content to the left
                    // Left-aligned title
                    Text("Favorites")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16) // Adds spacing from the top

                    Spacer().frame(height: 8) // Adjust space between the title and the list

                    // Song cards list
                    List {
                        ForEach(viewModel.favorites, id: \.objectID) { song in
                            SongRow(song: song) { toggledSong in
                                viewModel.toggleFavorite(song: toggledSong) // Handle heart action
                            }
                        }
                        .listRowBackground(Color.white) // Ensures each entry has a white background
                        .cornerRadius(8) // Adds rounded corners
                        .shadow(radius: 2) // Adds a slight shadow for better contrast
                    }
                    .scrollContentBackground(.hidden) // Ensures the background image is visible
                }
            }
            .onAppear {
                viewModel.fetchSongs()
            }
        }
    }
}
