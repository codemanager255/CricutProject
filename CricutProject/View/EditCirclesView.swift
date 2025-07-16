//
//  EditCirclesView.swift
//  CricutProject
//
//  Created by Arpit Mallick on 6/17/25.
//

import SwiftUI

struct EditCirclesView: View {
    @Binding var circles: [String]

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 30) {
                ForEach(circles.indices, id: \.self) { index in
                    switch circles[index] {
                    case "circle":
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.blue.opacity(0.3))
                    default:
                        EmptyView()
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button("Delete All") {
                    circles.removeAll()
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

                Button("Add") {
                    circles.append("circle")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

                Button("Remove") {
                    if !circles.isEmpty {
                        circles.removeLast()
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}
