//
//  Factory.swift
//  ReplaceNotificationCenterWithAdapter
//

import SwiftUI

struct Factory {
    private init() {}
}

// Root
extension Factory {
    static func createDogTabItem(
        model: [AnimalType],
        selection: @escaping (AnimalType) -> Void
    ) -> some View {
        AnimalView(animalTypes: model, selection: selection)
    }
    
    static func createCatTabItem(
        model: [AnimalType],
        selection: @escaping (AnimalType) -> Void
    ) -> some View {
        AnimalView(animalTypes: model, selection: selection)
    }
}

// Sub
extension Factory {
    static func createAnimalListView(viewModel: [Animal], selection: @escaping ((Animal) -> Void)) -> some View {
        AnimalListView(animals: viewModel, selection: selection)
    }
    
    static func createAnimalDetailView(animal: Animal, selection: @escaping (() -> Void), dismiss: (() -> Void)? = nil) -> some View {
        AnimalDetailView(animal: animal, selection: selection, dismiss: dismiss)
    }
    
    static func createPresentationView(selection: @escaping (() -> Void)) -> some View {
        PresentedView(selection: selection)
    }
}
