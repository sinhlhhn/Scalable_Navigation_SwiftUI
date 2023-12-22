//
//  AnimalDetailView.swift
//  ReplaceNotificationCenterWithAdapter
//
//  Created by SinhLH.FHN on 22/12/2023.
//

import SwiftUI

struct AnimalDetailView: View {
    let animal: Animal
    var selection: (() -> Void)?
    var dismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Text(animal.name)
                Spacer()
                Text(animal.color)
            }
            HStack {
                Button {
                    selection?()
                } label: {
                    Text("Pop to root")
                }
                .buttonStyle(.bordered)
                if let dismiss = dismiss {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss sheet")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .padding()
        .navigationTitle("Detail Animal")
    }
}

#Preview {
    NavigationStack {
        AnimalDetailView(animal: Animal(name: "Bull", color: "red"))
    }
}
