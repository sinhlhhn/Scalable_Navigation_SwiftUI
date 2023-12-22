//
//  ScalableNavigation.swift
//  ReplaceNotificationCenterWithAdapter
//

import SwiftUI

@main
struct ScalableNavigation: App {
    
    // We have to define maximum flow we can have in our app
    // Normally, we only need 2 flows, one for push and one for present
    // In this app, i need 3 flows because i have a TabView
    @StateObject private var dogFlow = Flow()
    @StateObject private var catPushFlow = Flow()
    @StateObject private var catPresentFlow = Flow()
    
    @State private var isPresented = false
    
    let animalTypes: [AnimalType]
    let animals: [Animal]
    
    init() {
        animalTypes = [
            AnimalType(type: "Dog"),
            AnimalType(type: "Cat")
        ]
        animals = [
            Animal(name: "Alaskan", color: "red"),
            Animal(name: "Bull", color: "black")
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                createDogTabItem()
                    .tabItem {
                        Label("Dog", systemImage: "dog.circle.fill")
                    }
                createCatTabItem()
                    .tabItem {
                        Label("Cat", systemImage: "cat.circle.fill")
                    }
            }
        }
    }
}

// Cat
extension ScalableNavigation {
    func createCatTabItem() -> some View {
        return NavigationStack(path: $catPushFlow.path) {
            Factory.createCatTabItem(
                model: animalTypes,
                selection: { _ in
                    catPushFlow.start(type: .pushTo(CatDestination.listCatView))
                })
            .navigationDestination(for: CatDestination.self, destination: { destination in
                createRootCatPushFlow(with: destination)
            })
        }
        
    }
    
    func createRootCatPushFlow(with destination: CatDestination) -> some View {
        Group {
            switch destination {
            case .listCatView:
                Factory.createAnimalListView(viewModel: animals) { _ in
                    isPresented = true
                }
                .sheet(isPresented: $isPresented, onDismiss: {
                    catPresentFlow.start(type: .popToRoot)
                }) {
                    createRootCatPresentFlow()
                }
                
            case .catDetailView(let animal):
                Factory.createAnimalDetailView(animal: animal) {
                    catPresentFlow.start(type: .popToRoot)
                }
            }
        }
    }
    
    func createRootCatPresentFlow() -> some View {
        return NavigationStack(path: $catPresentFlow.path) {
            Factory.createCatTabItem(
                model: animalTypes,
                selection: { viewModel in
                    catPresentFlow.start(type: .pushTo(CatDestination.listCatView))
                })
            .navigationDestination(for: CatDestination.self, destination: { destination in
                createSubPresentationView(with: catPresentFlow, to: destination)
            })
        }
    }
    
    func createSubPresentationView(with flow: Flow, to destination: CatDestination) -> some View {
        Group {
            switch destination {
            case .listCatView:
                Factory.createAnimalListView(viewModel: animals) { animal in
                    flow.start(type: .pushTo(CatDestination.catDetailView(animal)))
                }
            case .catDetailView(let animal):
                Factory.createAnimalDetailView(animal: animal) {
                    flow.start(type: .popToRoot)
                } dismiss: {
                    isPresented = false
                }
            }
        }
    }
}

// Dog
extension ScalableNavigation {
    
    func createDogTabItem() -> some View {
        return NavigationStack(path: $dogFlow.path) {
            Factory.createDogTabItem(
                model: animalTypes,
                selection: { viewModel in
                    dogFlow.start(type: .pushTo(DogDestination.listDogView))
                })
            .navigationDestination(for: DogDestination.self, destination: { destination in
                createRootDogPushFlow(with: destination)
            })
        }
    }
    
    func createRootDogPushFlow(with destination: DogDestination) -> some View {
        Group {
            switch destination {
            case .listDogView:
                Factory.createAnimalListView(viewModel: animals) { animal in
                    dogFlow.start(type: .pushTo(DogDestination.dogDetailView(animal)))
                }
                
            case .dogDetailView(let animal):
                Factory.createAnimalDetailView(animal: animal) {
                    dogFlow.start(type: .popToRoot)
                }
            }
        }
    }
}
