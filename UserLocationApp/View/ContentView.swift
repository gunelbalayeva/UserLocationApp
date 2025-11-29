//
//  ContentView.swift
//  UserLocationApp
//
//  Created by User on 28.11.25.
//

import SwiftUI
import MapKit
struct ContentView: View {
    
    @State private var viewModel = ContentViewModel()
    
    
    var body: some View {
        Map(initialPosition: .region(viewModel.region)) {
            MapDetails.defaultBaku
            .tint(.pink)
        }
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServicesInEnabled()
            }
    }
}

#Preview {
    ContentView()
}
