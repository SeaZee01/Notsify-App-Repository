//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(showsIndicators: true) {
            GeometryReader { geometry in
                VStack() {
                    // Creating the side bar for the Home Page
                    // Defining object
                    Rectangle()
                        // Defining object size
                        .frame(width:235, height: 2000)
                        // Defining object colour
                        .foregroundColor(Color("NormOrange"))
                        // Defining object position
                        .position(x: -1, y: 0)
                    
                    // Creating the top bar for the Home Page
                    // Defining object
                    Rectangle()
                        // Defining object size
                        .frame(width: geometry.size.width * 2, height: 600)
                        // Defining object colour
                        .foregroundColor(Color("DarkOrange"))
                        // Defining object position
                        .position(x: 0, y: -175)
                    }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
