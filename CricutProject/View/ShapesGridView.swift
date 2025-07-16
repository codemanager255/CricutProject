//
//  ShapesGridView.swift
//  CricutProject
//
//  Created by Arpit Mallick on 6/17/25.
//

import SwiftUI

struct ShapesGridView1: View {
    @StateObject private var viewModel = ShapesViewModel(networkService: WebApiManager())
    @State private var shapes: [String] = []
    @State private var navigateToEditCircles = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Button("Clear All") {
                            shapes.removeAll()
                        }
                        .padding(.leading)

                        Spacer()

                        Button("Edit Circles") {
                            navigateToEditCircles = true
                        }
                        .padding(.trailing)
                    }

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 20)], spacing: 30) {
                        ForEach(shapes.indices, id: \.self) { index in
                            switch shapes[index] {
                            case "circle":
                                Circle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.blue.opacity(0.3))
                            case "square":
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.blue.opacity(0.3))
                            case "triangle":
                                TriangleShape()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.blue.opacity(0.3))
                            default:
                                EmptyView()
                            }
                        }
                    }
                    Spacer()

                    HStack {
                        switch viewModel.viewState {
                        case .loading:
                            ProgressView()
                        case .load(let buttons):
                            ForEach(buttons) { button in
                                Button(action: {
                                    shapes.append(button.drawPath)
                                }) {
                                    Text(button.name)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                }
                            }
                        case .error(let error):
                            Text(error)
                        }
                    }
                    .padding()
                }
                NavigationLink(
                    destination: EditCirclesView(circles: Binding(
                        get: { shapes.filter { $0 == "circle" } },
                        set: { newCircles in
                            shapes = shapes.filter { $0 != "circle" } + newCircles
                        }
                    )),
                    isActive: $navigateToEditCircles
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
        .task {
            await viewModel.fetchShapes()
        }
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
