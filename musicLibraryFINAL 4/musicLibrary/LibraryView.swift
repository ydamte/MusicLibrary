//
//  LibraryView.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var viewModel: MusicVaultViewModel

    @State private var isPresentingAddSongView = false

    init() {
        // Initialize with a default context; will update in onAppear
        self.viewModel = MusicVaultViewModel(context: PersistenceController.shared.container.viewContext)
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    // Move the list downward with a spacer
                    Spacer().frame(height: 30)

                    List {
                        ForEach(viewModel.songs, id: \.objectID) { song in
                            SongRow(song: song) { toggledSong in
                                viewModel.toggleFavorite(song: toggledSong)
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.map { viewModel.songs[$0] }.forEach(viewModel.deleteSong)
                        }
                    }
                    .scrollContentBackground(.hidden) // Ensure list background is transparent
                }
            }
            .toolbar {
                // Adjust spacing around the "Library" title
                ToolbarItem(placement: .principal) {
                    Text("Song Library")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, -10) // Moves the title slightly upward
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddSongView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddSongView) {
                AddSongView()
                    .environment(\.managedObjectContext, context)
            }
        }
        .onAppear {
            // Update the viewModel's context if needed
            viewModel.updateContextIfNeeded(context: context)
        }
    }
}
