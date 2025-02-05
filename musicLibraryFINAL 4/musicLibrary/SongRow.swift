//
//  SongRow.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//

import SwiftUI

struct SongRow: View {
    @ObservedObject var song: Song
    let onToggleFavorite: (Song) -> Void
    @State private var isPresentingEditView = false

    var body: some View {
        HStack {
            // Song Details
            VStack(alignment: .leading) {
                Text(song.title ?? "Unknown Title")
                    .font(.headline)
                Text(song.artist ?? "Unknown Artist")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            // Heart Button
            Button(action: {
                onToggleFavorite(song) // Toggle favorite status
            }) {
                Image(systemName: song.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle()) // Prevents interaction conflicts
        }
        .contentShape(Rectangle()) // Makes the entire row tappable except the heart
        .onTapGesture {
            isPresentingEditView = true // Open edit card when the row is tapped
        }
        .sheet(isPresented: $isPresentingEditView) {
            AddSongView(songToEdit: song) // Reuse AddSongView for editing
        }
        .padding(.vertical, 4)
    }
}

