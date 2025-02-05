//
//  MusicLibraryViewModel.swift
//  musicLibrary
//
//  Created by Yeabsera Damte on 11/16/24.
//


import CoreData
import SwiftUI
import Combine


class MusicVaultViewModel: ObservableObject {
    @Published var songs: [Song] = []
    @Published var favorites: [Song] = []

    private var context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchSongs()
        registerForContextChanges()
    }

    func updateContextIfNeeded(context: NSManagedObjectContext) {
        if self.context != context {
            self.context = context
            fetchSongs()
            // Re-register for notifications with the new context
            registerForContextChanges()
        }
    }

    private func registerForContextChanges() {
        // Cancel previous subscriptions
        cancellables.removeAll()

        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange, object: context)
            .sink { [weak self] _ in
                self?.fetchSongs()
            }
            .store(in: &cancellables)
    }

    func fetchSongs() {
        let request: NSFetchRequest<Song> = Song.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Song.title, ascending: true)]

        do {
            songs = try context.fetch(request)
            favorites = songs.filter { $0.isFavorite }
            print("All songs: \(songs.count), Favorites: \(favorites.count)")
        } catch {
            print("Error fetching songs: \(error)")
        }
    }

    func toggleFavorite(song: Song) {
        song.isFavorite.toggle()
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    func deleteSong(song: Song) {
        context.delete(song)
        saveContext()
    }
}
