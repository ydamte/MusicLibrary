//
//  EditSongView.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//

import SwiftUI

struct EditSongView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var song: Song

    @State private var title: String
    @State private var artist: String
    @State private var year: String
    @State private var genre: String
    @State private var location: String
    @State private var note: String

    init(song: Song) {
        self.song = song
        _title = State(initialValue: song.title ?? "")
        _artist = State(initialValue: song.artist ?? "")
        _year = State(initialValue: "\(song.year)")
        _genre = State(initialValue: song.genre ?? "")
        _location = State(initialValue: song.location ?? "")
        _note = State(initialValue: song.note ?? "")
    }

    var body: some View {
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
            .navigationTitle("Edit Song")
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

    private func saveSong() {
        song.title = title
        song.artist = artist
        song.year = Int16(year) ?? 0
        song.genre = genre
        song.location = location
        song.note = note

        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving song: \(error)")
        }
    }
}
