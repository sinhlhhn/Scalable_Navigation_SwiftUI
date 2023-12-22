//
//  Flow.swift
//  ReplaceNotificationCenterWithAdapter
//

import SwiftUI



enum CatDestination: Hashable {
    case listCatView
    case catDetailView(Animal)
}

enum DogDestination: Hashable {
    case listDogView
    case dogDetailView(Animal)
}

class Flow: ObservableObject {
    @Published var path: NavigationPath = .init()
    @Published var type: NavigationType = .root
    
    enum NavigationType {
        case pushTo(any Hashable)
        case popBack
        case popToRoot
        case root
    }
    
    func start(type: NavigationType) {
        switch type {
        case .pushTo(let destination):
            path.append(destination)
        case .popBack:
            path.removeLast()
        case .popToRoot, .root:
            path.removeLast(path.count)
        }
    }
}
