//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

// Importing the Swift library
import SwiftUI
//Libary for manipulating the .txt files
import Cocoa
extension String{
    //get the filename from a string
    func fileName() -> String{
        //finds the file name by deleting the file extension attached
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    //get the file type from the string
    func fileType() -> String{
        //finds the file type by specifying for the file extension
        return URL(fileURLWithPath: self).pathExtension
    }
}

//function which reads the text file
func readingFile(inputFile: String) -> String{
    //breaking up the file into two components
    //the file name
    let nameFile =  inputFile.fileName()
    //the file type
    let typeFile = inputFile.fileType()
    //getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let readFile = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    //reading the data on the text file
    do {
        let savedInfo = try String(contentsOf: readFile)
        return savedInfo
        //if the folder doesn't exist
    } catch {
        //if the file doesn't exist then return the fact that it doesn't exist
        return error.localizedDescription
    }
}

func writeFile(Filename: String, Data: String){
    //breaking up the file into two components
    //the file name
    let nameFile =  Filename.fileName()
    //the file type
    let typeFile = Filename.fileType()
    //getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    //saving the data
    guard let data = Data.data(using: .utf8) else{
        print("can't convert string to data")
        return
    }
    
    do{
        try data.write(to: Filename)
        print("data written: \(data)")
    } catch{
        print(error.localizedDescription)
    }
}

struct ContentView: View {
    // Defining the current page variable
    @State var currentPage = 0
    // Defining sticky note number variable
    @State var noteNumber = 0
    // defining the variable for the general notes string
    @State private var GeneralNoteText: String = ""
    @State private var StickyText1: String = ""
    @State private var StickyText2: String = ""
    @State private var StickyText3: String = ""
    @State private var StickyText4: String = ""
    @State private var StickyText5: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            // Switching case statements to dictate the application page
            switch currentPage {
            case 1:
                GENERALNOTESPAGE(currentPage: $currentPage, GeneralNoteText: $GeneralNoteText)
                GeneralNotePageButtons
                textEditorView
            case 2:
                STICKYNOTEPAGE(currentPage: $currentPage)
                StickyNotePageButtons
                
            case 3:
                Text("Mind map")
            default:
                HOMEPAGE(currentPage: $currentPage)
                HomePageButtons
            }
            // Switching case statements to dictate what sticky notes appear
            // Note that after default case statement has been reached no other case statements can be active (needs adjustment)
            if currentPage == 2 {
                switch noteNumber {
                case 1:
                    StickyNote1View
                    StickyNote2View
                case 2:
                    StickyNote1View
                    StickyNote2View
                    StickyNote3View
                case 3:
                    StickyNote1View
                    StickyNote2View
                    StickyNote3View
                    StickyNote4View
                case 4:
                    StickyNote1View
                    StickyNote2View
                    StickyNote3View
                    StickyNote4View
                    StickyNote5View
                    
                default:
                    StickyNote1View
                    }
                }
            }
        }
    }
    // Creating the Home page for the application
    struct HOMEPAGE: View{
        @Binding var currentPage: Int
        var body: some View{
            GeometryReader { geometry in
                VStack() {
                    // Creating the side bar for the Home Page
                    // Defining the object
                    Rectangle()
                    // Defining the object size
                        .frame(width:235, height: 6000)
                    // Defining the object colour
                        .foregroundColor(Color("NormOrange"))
                    // Defining the object position
                        .position(x: -1, y: 0)
                    
                    // Creating the top bar for the Home Page
                    // Defining the object
                    Rectangle()
                    // Defining the object size
                        .frame(width: geometry.size.width * 2, height: 600)
                    // Defining the object colour
                        .foregroundColor(Color("DarkOrange"))
                    // Defining the object position
                        .position(x: 0, y: -175)
                    
                    // Inserting the image that serves as our application title.
                    Image("TitleSet")
                    // Resizing the image
                        .resizable()
                        .scaledToFit()
                        .frame(width:425, height: 425)
                    // Changing the image position
                        .position(x: geometry.size.width/2, y: 50)
                    
                    Circle()
                    // Creating the object border
                        .strokeBorder(Color.black, lineWidth: 1)
                    // Defining the object colour
                        .background(Circle().fill(Color.white))
                    // Defining the object size
                        .frame(width: 100, height: 100)
                    // Defining the object position
                        .position(x: 70, y: 40)
                    
                    // Inserting our logo image
                    Image("LogoSet")
                    // Resizing the image
                        .resizable()
                        .scaledToFit()
                        .frame(width:130, height: 130)
                    // Changing the image position
                        .position(x: 67.5, y: 47)
                    // Creating the help button
                    // Labelling the button with the link to our website
                    Link("Help", destination: URL(string: "https://www.canva.com/design/DAGNBe5W3jc/KvojK8gN0hCMNO4tXyXDNw/view?utm_content=DAGNBe5W3jc&utm_campaign=designshare&utm_medium=link&utm_source=editor#1")!)
                    // Changing the colour and shape of the button
                        .padding()
                        .background(Color("NormOrange"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    // Changing the position of the button
                        .position(x: geometry.size.width*0.97, y: geometry.size.height*64)
                }
            }
        }
    }
    // General notes page for the application
    struct GENERALNOTESPAGE: View{
        //variable for changing pages
        @Binding var currentPage: Int
        //variable for getting the general note text
        @Binding var GeneralNoteText: String
        var body: some View{
            GeometryReader { geometry in
                VStack{
                    // Creating the side bar for the Home Page
                    // Defining the object
                    Rectangle()
                    // Defining the object size
                        .frame(width:235, height: 6000)
                    // Defining the object colour
                        .foregroundColor(Color("NormOrange"))
                    // Defining the object position
                        .position(x: -1, y: 0)
                    
                    // Creating the top bar for the Home Page
                    // Defining the object
                    Rectangle()
                    // Defining the object size
                        .frame(width: geometry.size.width * 2, height: 600)
                    // Defining the object colour
                        .foregroundColor(Color("DarkOrange"))
                    // Defining the object position
                        .position(x: 0, y: -175)
                    
                    // Inserting the image that serves as our application title.
                    Image("TitleSet")
                    // Resizing the image
                        .resizable()
                        .scaledToFit()
                        .frame(width:425, height: 425)
                    // Changing the image position
                        .position(x: geometry.size.width/2, y: 50)
                    
                    Circle()
                    // Creating the object border
                        .strokeBorder(Color.black, lineWidth: 1)
                    // Defining the object colour
                        .background(Circle().fill(Color.white))
                    // Defining the object size
                        .frame(width: 100, height: 100)
                    // Defining the object position
                        .position(x: 70, y: 40)
                    
                    // Inserting our logo image
                    Image("LogoSet")
                    // Resizing the image
                        .resizable()
                        .scaledToFit()
                        .frame(width:130, height: 130)
                    // Changing the image position
                        .position(x: 67.5, y: 47)
                    
                    
                    // Creating the help button
                    // Labelling the button with the link to our website
                    Link("Help", destination: URL(string: "https://www.canva.com/design/DAGNBe5W3jc/KvojK8gN0hCMNO4tXyXDNw/view?utm_content=DAGNBe5W3jc&utm_campaign=designshare&utm_medium=link&utm_source=editor#1")!)
                    // Changing the colour and shape of the button
                        .padding()
                        .background(Color("NormOrange"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    // Changing the position of the button
                        .position(x: geometry.size.width*0.97, y: geometry.size.height*64)
                }
            }
        }
    }
    
    // Creating the Sticky Notes page for the application
    struct STICKYNOTEPAGE: View{
        @Binding var currentPage: Int
        var body: some View{
            GeometryReader { geometry in
                VStack() {
                    // Creating the side bar for the Home Page
                    // Defining the object
                    Rectangle()
                    // Defining the object size
                        .frame(width:150, height: 6000)
                    // Defining the object colour
                        .foregroundColor(Color("NormOrange"))
                    // Defining the object position
                        .position(x: -1, y: 0)
                    
                    // Creating the top bar for the Home Page
                    // Defining the object
                    Rectangle()
                    // Defining the object size
                        .frame(width: geometry.size.width * 2, height: 600)
                    // Defining the object colour
                        .foregroundColor(Color("DarkOrange"))
                    // Defining the object position
                        .position(x: 0, y: -175)
                    
                    // Inserting the image that serves as our application title.
                    Image("TitleSet")
                    // Resizing the image
                        .resizable()
                        .scaledToFit()
                        .frame(width:425, height: 425)
                    // Changing the image position
                        .position(x: geometry.size.width/2, y: 50)
                    
                    Circle()
                    // Creating the object border
                        .strokeBorder(Color.black, lineWidth: 1)
                    // Defining the object colour
                        .background(Circle().fill(Color.white))
                    // Defining the object size
                        .frame(width: 100, height: 100)
                    // Defining the object position
                        .position(x: 70, y: 40)
                    
                    // Inserting our logo image
                    Image("LogoSet")
                    // Resizing the image
                        .resizable()
                        .scaledToFit()
                        .frame(width:130, height: 130)
                    // Changing the image position
                        .position(x: 67.5, y: 47)
                    // Creating the help button
                    // Labelling the button with the link to our website
                    Link("Help", destination: URL(string: "https://www.canva.com/design/DAGNBe5W3jc/KvojK8gN0hCMNO4tXyXDNw/view?utm_content=DAGNBe5W3jc&utm_campaign=designshare&utm_medium=link&utm_source=editor#1")!)
                    // Changing the colour and shape of the button
                        .padding()
                        .background(Color("NormOrange"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    // Changing the position of the button
                        .position(x: geometry.size.width*0.97, y: geometry.size.height*64)
                    
                    // Creating a button that makes the sticky notes display
                    
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
    
    // Home page buttons extension preview
    private extension ContentView{
        var HomePageButtons: some View{
            GeometryReader { geometry in
                // Creating the first button for the Home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(15)
                // Defining the object size
                    .frame(width: 90, height: 90)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:58, y:175)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 0
                    let myData = readingFile(inputFile: "Textfile.txt")
                    print(myData)
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("HomeIcon")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:168)
                
                // Creating the second button for the Home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(15)
                // Defining the object size
                    .frame(width: 90, height: 90)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:58, y:275)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 1
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("GeneralIcon")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:267)
                
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 2
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("HomeIcon")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:366)
            }
        }
    }
    
    // General note page buttons extension preview
    private extension ContentView{
        var GeneralNotePageButtons: some View{
            GeometryReader { geometry in
                // Button to go to home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(15)
                // Defining the object size
                    .frame(width: 90, height: 90)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:58, y:175)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 0
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("HomeIcon")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:168)
            }
        }
    }
    
    // Sticky Note buttons extension preview
    private extension ContentView{
        var StickyNotePageButtons: some View{
            GeometryReader { geometry in
                // Button to go to home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(10)
                // Defining the object size
                    .frame(width: 60, height: 60)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:37, y:160)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 0
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("HomeIcon")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:38, y:160)
                
                // Button to create a new sticky note
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(10)
                // Defining the object size
                    .frame(width: 60, height: 60)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:37, y:235)
                
                // Defining button actions to change note number
                Button(action: {
                    noteNumber += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:38, y:235)
            }
        }
    }
    
    private extension ContentView{
        var textEditorView: some View{
            GeometryReader { geometry in
                TextEditor(text: $GeneralNoteText)
                    .frame(width: geometry.size.width * 0.7,height: geometry.size.height * geometry.size.height)
                    .position(x:geometry.size.width * 0.6, y:geometry.size.height * 24)
            }
        }
    }
    
    // Creating views for each sticky note
    private extension ContentView{
        var StickyNote1View: some View{
            GeometryReader { geometry in
                TextEditor(text: $StickyText1)
                    // Defining the note's size and position
                    .frame(width: 225,height: 225)
                    .position(x:200, y:220)
                // Colour commented out as it doesn't function as intended. Needs to be reviewed.
                //.background(Color.clear)
                //.background(Color("StickyYellow"))
                
            }
        }
    }
    // Creating views for each sticky note
    private extension ContentView{
        var StickyNote2View: some View{
            GeometryReader { geometry in
                TextEditor(text: $StickyText2)
                    // Defining the note's size and position
                    .frame(width: 225,height: 225)
                    .position(x:450, y:220)
                // Colour commented out as it doesn't function as intended. Needs to be reviewed.
                //.background(Color.clear)
                //.background(Color("StickyPink"))
            }
        }
    }
    // Creating views for each sticky note
    private extension ContentView{
        var StickyNote3View: some View{
            GeometryReader { geometry in
                TextEditor(text: $StickyText3)
                    // Defining the note's size and position
                    .frame(width: 225,height: 225)
                    .position(x:700, y:220)
                // Colour commented out as it doesn't function as intended. Needs to be reviewed.
                //.background(Color.clear)
                //.background(Color("StickyPurple"))
            }
        }
    }
    // Creating views for each sticky note
    private extension ContentView{
        var StickyNote4View: some View{
            GeometryReader { geometry in
                TextEditor(text: $StickyText4)
                    // Defining the note's size and position
                    .frame(width: 225,height: 225)
                    .position(x:950, y:220)
                // Colour commented out as it doesn't function as intended. Needs to be reviewed.
                //.background(Color.clear)
                //.background(Color("StickyGreen"))
            }
        }
    }
    // Creating views for each sticky note
    private extension ContentView {
        var StickyNote5View: some View {
            GeometryReader { geometry in
                TextEditor(text: $StickyText5)
                    // Defining the note's size and position
                    .frame(width: 225, height: 225)
                    .position(x: 1200, y: 220)
                // Colour commented out as it doesn't function as intended. Needs to be reviewed.
                //.background(Color.clear)
                //.background(Color("StickyBlue"))
            }
        }
    }
