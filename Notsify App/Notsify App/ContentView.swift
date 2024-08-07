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
                        .frame(width:235, height: 6000)
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
                    
                    // Inserting the image that serves as our application title.
                    Image("TitleSet")
                        .resizable()
                        .scaledToFit()
                        .frame(width:425, height: 425)
                        .position(x: 650, y: 50)
                    
                    Circle()
                    // Creating object border
                        .strokeBorder(Color.black, lineWidth: 1)
                    // Defining object colour
                        .background(Circle().fill(Color.white))
                    // Defining object size
                        .frame(width: 100, height: 100)
                    // Defining object position
                        .position(x: 70, y: 40)
                    
                    // Inserting our logo image.
                    Image("LogoSet")
                        .resizable()
                        .scaledToFit()
                        .frame(width:130, height: 130)
                        .position(x: 67.5, y: 47)
                    
                    // Creating the help button
                    // BUTTON CURRENTLY DOES NOT APPEAR NEEDS FIXING
                    Link(destination: URL(string: "https://www.canva.com/design/DAGNBe5W3jc/KvojK8gN0hCMNO4tXyXDNw/view?utm_content=DAGNBe5W3jc&utm_campaign=designshare&utm_medium=link&utm_source=editor#1")!) {
                        Image("HelpButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .position(x: 67.5, y: 47)
                    }
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

