//
//  AddSongView.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//

import SwiftUI


struct AddSongView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode

    // State properties for the song details
    @State private var title: String = ""
    @State private var artist: String = ""
    @State private var year: String = ""
    @State private var genre: String = ""
    @State private var location: String = ""
    @State private var note: String = ""

    var songToEdit: Song?

    // Optional initializer for editing an existing song
    init(songToEdit: Song? = nil) {
        self.songToEdit = songToEdit
        if let song = songToEdit {
            _title = State(initialValue: song.title ?? "")
            _artist = State(initialValue: song.artist ?? "")
            _year = State(initialValue: "\(song.year)")
            _genre = State(initialValue: song.genre ?? "")
            _location = State(initialValue: song.location ?? "")
            _note = State(initialValue: song.note ?? "")
        }
    }

    var body: some View {
        ZStack {
            Color(red: 255 / 255, green: 229 / 255, blue: 180 / 255)
                .ignoresSafeArea()

            NavigationView {
                Form {
                    Section(header: Text("Song Details")) {
                        TextField("Title", text: $title)
                        TextField("Artist", text: $artist)
                        TextField("Year", text: $year)
                            .keyboardType(.numberPad)
                        TextField("Genre", text: $genre)
                        TextField("Location", text: $location)
                    }

                    Section(header: Text("Notes")) {
                        TextField("Add a note", text: $note)
                    }
                }
                .navigationTitle(songToEdit == nil ? "Add Song" : "Edit Song")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            saveSong()
                        }
                    }
                }
            }
        }
    }

    private func saveSong() {
        if let song = songToEdit {
            // Editing existing song
            song.title = title
            song.artist = artist
            song.year = Int16(year) ?? 0
            song.genre = genre
            song.location = location
            song.note = note
        } else {
            // Adding a new song
            let newSong = Song(context: context)
            newSong.title = title
            newSong.artist = artist
            newSong.year = Int16(year) ?? 0
            newSong.genre = genre
            newSong.location = location
            newSong.note = note
            newSong.isFavorite = false
        }

        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving song: \(error)")
        }
    }
}

