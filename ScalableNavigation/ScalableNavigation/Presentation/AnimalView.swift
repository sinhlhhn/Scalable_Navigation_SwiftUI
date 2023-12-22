//
//  HomeView.swift
//  ReplaceNotificationCenterWithAdapter
//
//  Created by SinhLH.FHN on 22/12/2023.
//

import SwiftUI

struct AnimalType {
    let type: String
}

struct AnimalView: View {
    var animalTypes: [AnimalType]
    var selection: ((AnimalType) -> Void)?
    
    var body: some View {
        List {
            ForEach(animalTypes, id: \.type) { animalType in
                HStack {
                    Button {
                        selection?(animalType)
                    } label: {
                        Text(animalType.type)
                            .foregroundStyle(Color(UIColor.label))
                    }
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AnimalView(animalTypes: [
            AnimalType(type: "Dog"),
            AnimalType(type: "Cat")
        ])
    }
}
