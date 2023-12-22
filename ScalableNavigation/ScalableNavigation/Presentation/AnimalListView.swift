//
//  AnimalListView.swift
//  ReplaceNotificationCenterWithAdapter
//
//  Created by SinhLH.FHN on 22/12/2023.
//

import SwiftUI

struct Animal: Hashable {
    let name: String
    let color: String
}

struct AnimalListView: View {
    var animals: [Animal]
    var selection: ((Animal) -> Void)?
    
    var body: some View {
        List {
            ForEach(animals, id: \.name) { animal in
                HStack {
                    Button {
                        selection?(animal)
                    } label: {
                        Text(animal.name)
                            .foregroundStyle(Color(UIColor.label))
                    }
                }
            }
        }
        .navigationTitle("List Animal")
    }
}

#Preview {
    NavigationStack {
        AnimalListView(animals: [
            Animal(name: "Alaskan", color: "red"),
            Animal(name: "Bull", color: "black")
        ])
    }
}
