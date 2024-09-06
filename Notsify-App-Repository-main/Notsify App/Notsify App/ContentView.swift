//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

// Importing the Swift library
import SwiftUI
// Importing the libary for manipulating .txt files
import Cocoa
extension String{
    // Getting the filename from a string
    func fileName() -> String{
        // Finding the file name by deleting the file extension attached
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    // Getting the file type from the string
    func fileType() -> String{
        // Finding the file type by specifying for the file extension
        return URL(fileURLWithPath: self).pathExtension
    }
}

// Creating a function which reads the text file and is recyclable for more efficency
func readingFile(inputFile: String) -> String{
    // Breaking up the file into two components
    // The file name
    let nameFile =  inputFile.fileName()
    // The file type
    let typeFile = inputFile.fileType()
    // Getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let readFile = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    // Reading the data on the .txt file
    do {
        let savedInfo = try String(contentsOf: readFile)
        return savedInfo
        // Defining the process if the folder doesn't exist
    } catch {
        // If the file doesn't exist then return the fact that it doesn't exist
        return "Write text here:"
    }
}
// Creating a function which writes a text file and can create files. Taking 2 parameters - the file name and data on the .txt file
func writeFile(Filename: String, Data: String){
    // Breaking up the file into two components
    // The file name
    let nameFile =  Filename.fileName()
    // The file type
    let typeFile = Filename.fileType()
    // Retreiving the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    // Saving the data
    guard let data = Data.data(using: .utf8) else{
        print("can't convert string to data")
        return
    }
    // Printing to the console whether the data transmision was successful and if so how many bytes, else an error which specifies why it failed
    do{
        try data.write(to: Filename)
        print("data written: \(data)")
    } catch{
        print(error.localizedDescription)
    }
}

// Creating a function which allows users to delete files
func deleteFile(_ fileToDelete: String){
    // Breaking up the filename and extension
    // The file name
    let nameFile =  fileToDelete.fileName()
    // The file type
    let typeFile = fileToDelete.fileType()
    // Getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    do {
        try FileManager.default.removeItem(at: Filename)
    }catch{
        print(error.localizedDescription)
    }
}

// The function used for the mindmap tiles to figure out which mind map tile button was clicked so the line connecting mind map tiles is going between the correct tiles. The parameter taken as an intiger tells the funciton which number tile clicked the button. (If 1 then tile 1 clicked, if 2 then tile 2 clicked and so on.)
// The function to create a line because XCode doesn't have there own in-built function
struct Line: Shape{
    // The two parameters (start and end point of the line)
    var StartPoint: CGPoint
    var EndPoint: CGPoint
    // The function used to create the line
    func path(in rect: CGRect) -> Path {
        // The path between start and end point being created
        var path = Path()
        path.move(to: StartPoint)
        path.addLine(to: EndPoint)
        // Returning the path
        return path
    }
}

// Main Content View
struct ContentView: View {
    // Defining the current page variable
    @State var currentPage = 0
    // defining the variable for the general notes string
    @State var GeneralNoteText: String = readingFile(inputFile: "GeneralNotesText")
    // Defining sticky note number variable
    @State var noteNumber = 0
    // Defining the variable for the sticky notes string
    @State private var StickyText1: String = readingFile(inputFile: "StickyText1")
    @State private var StickyText2: String = readingFile(inputFile: "StickyText2")
    @State private var StickyText3: String = readingFile(inputFile: "StickyText3")
    @State private var StickyText4: String = readingFile(inputFile: "StickyText4")
    @State private var StickyText5: String = readingFile(inputFile: "StickyText5")
    
    // Defining the variable for the position of all 5 sticky notes
    @State var StickyPos1: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos2: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos3: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos4: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos5: CGSize = CGSize(width: 100, height: 150)
    
    // Defining the variable position and string for mindmap title square
    @State private var MindMapTitleStr: String = readingFile(inputFile: "MindMapTitle")
    @State var MindMapTitlePos: CGSize = CGSize(width: 500, height: 500)
    
    // Defining the variable for amount of current mind map tiles in use.
    @State var TileAmount = 0
    
    // The variable for mind map strings
    @State private var MindMapStr1: String = readingFile(inputFile: "MindMapStr1")
    @State private var MindMapStr2: String = readingFile(inputFile: "MindMapStr2")
    @State private var MindMapStr3: String = readingFile(inputFile: "MindMapStr3")
    @State private var MindMapStr4: String = readingFile(inputFile: "MindMapStr4")
    @State private var MindMapStr5: String = readingFile(inputFile: "MindMapStr5")
    @State private var MindMapStr6: String = readingFile(inputFile: "MindMapStr6")
    @State private var MindMapStr7: String = readingFile(inputFile: "MindMapStr7")
    // The positions of MindMapTiles
    @State var MindMapPos1: CGSize = CGSize(width: 300, height: 300)
    @State var MindMapPos2: CGSize = CGSize(width: 500, height: 300)
    @State var MindMapPos3: CGSize = CGSize(width: 700, height: 300)
    @State var MindMapPos4: CGSize = CGSize(width: 900, height: 300)
    @State var MindMapPos5: CGSize = CGSize(width: 300, height: 600)
    @State var MindMapPos6: CGSize = CGSize(width: 500, height: 600)
    @State var MindMapPos7: CGSize = CGSize(width: 700, height: 600)
    
    // Variables for lines to know which mindmap tile it should be going from.
    @State var StartLineLocation1: CGSize = CGSize(width: 300, height: 300)
    @State var StartLineLocation2: CGSize = CGSize(width: 500, height: 300)
    @State var StartLineLocation3: CGSize = CGSize(width: 700, height: 300)
    @State var StartLineLocation4: CGSize = CGSize(width: 900, height: 300)
    @State var StartLineLocation5: CGSize = CGSize(width: 300, height: 600)
    @State var StartLineLocation6: CGSize = CGSize(width: 500, height: 600)
    @State var StartLineLocation7: CGSize = CGSize(width: 700, height: 600)
    var body: some View {
        ScrollView(showsIndicators: true) {
            // Switching case statements to dictate the application page is active
            switch currentPage {
                // Case 1 is the General notes page
            case 1:
                // The basic outline of the page for every page that isn't the home page
                PageOutline
                // The general notes page related elements such as the buttons
                GENERALNOTESPAGE(currentPage: $currentPage, GeneralNoteText: $GeneralNoteText)
                GeneralNotePageButtons
                // The text editor in the general notes page
                textEditorView
                // Case 2 is the stickynote page
            case 2:
                // The basic outline of the page for every page that isn't the home page
                PageOutline
                // The stickynote page which controls all 5 sticky notes and there position.
                STICKYNOTEPAGE(currentPage: $currentPage, noteNumber: $noteNumber, StickyText1: $StickyText1, StickyText2: $StickyText2, StickyText3: $StickyText3, StickyText4: $StickyText4, StickyText5: $StickyText5, StickyPos1: $StickyPos1, StickyPos2: $StickyPos2, StickyPos3: $StickyPos3, StickyPos4: $StickyPos4, StickyPos5: $StickyPos5)
                //the buttons for the stickynote page
                StickyNotePageButtons
                // Case three is the mind map page
            case 3:
                // The basic outline of the page for every page that isn't the home page
                ZStack{
                    PageOutline
                    MindMapButtons
                    MindMapTitle
                    if TileAmount > 0{
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos1.width + 100, y: MindMapPos1.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile1
                    }
                    if TileAmount > 1 {
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos2.width + 100, y: MindMapPos2.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile2
                    }
                    if TileAmount > 2{
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos3.width + 100, y: MindMapPos3.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile3
                    }
                    if TileAmount > 3 {
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos4.width + 100, y: MindMapPos4.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile4
                    }
                    if TileAmount > 4{
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos5.width + 100, y: MindMapPos5.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile5
                    }
                    if TileAmount > 5 {
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos6.width + 100, y: MindMapPos6.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile6
                    }
                    if TileAmount > 6{
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos7.width + 100, y: MindMapPos7.height + 60))
                            .stroke(Color.black, lineWidth: 3)
                            .zIndex(-1)
                        MindMapTile7
                    }
                }
            // The default case (not 1 2 or 3) is the homepage
            default:
                // The homepage outline (very simila to page outline but a few different features)
                HOMEPAGE(currentPage: $currentPage)
                // Homepage buttons
                HomePageButtons
            }
        }
        // The minimum width and height the screen can be moved to (This insures you can't make the screen small or big.)
        .frame(minWidth: 700, minHeight:500)
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
                
                // Inserting the image that serves as our application title
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
                    .position(x: geometry.size.width*0.955, y: 22)
                }
            }
        }
    }
// Creating the General notes page for the application
struct GENERALNOTESPAGE: View{
    // Defining the variable for changing pages
    @Binding var currentPage: Int
    // Defining the variable for getting the General note text
    @Binding var GeneralNoteText: String
    var body: some View{
        GeometryReader { geometry in
            VStack{
                //the ability to change notes
                
                // Defining button actions to save as a new file
                // This can't be placed in the generalNotesButtons because it needs access to the GeneralNotesText variable which is a binding var and can't be used in extension pages
                Button(action: {
                    writeFile(Filename: "GeneralNotesText", Data: GeneralNoteText)
                    let myData = readingFile(inputFile: "GeneralNotesText")
                    print(myData)
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Save")
                        // Resizing the icon image
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:37, y:255)
            }
        }
    }
}

// Creating the Sticky notes page for the application
struct STICKYNOTEPAGE: View{
    // Defining the variable for controlling currentPage
    @Binding var currentPage: Int
    // Defining the variable for the number of sticky notes to display
    @Binding var noteNumber: Int
    // Defining the string variables for all 5 sticky notes
    @Binding var StickyText1: String
    @Binding var StickyText2: String
    @Binding var StickyText3: String
    @Binding var StickyText4: String
    @Binding var StickyText5: String
    //Defining the variable for the position of all 5 sticky notes
    @Binding var StickyPos1: CGSize
    @Binding var StickyPos2: CGSize
    @Binding var StickyPos3: CGSize
    @Binding var StickyPos4: CGSize
    @Binding var StickyPos5: CGSize
    // The displayed view
    var body: some View{
        GeometryReader { geometry in
        // The sticky notes
            // The yellow note
            if noteNumber >= 0{
                ZStack{
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos1)
                        // // Changing the outline color for note #1 (the yellow note)
                        .foregroundColor(Color("StickyYellowOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos1 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos1.width <= 77 {
                                        StickyPos1.width = 77
                                    }
                                    if StickyPos1.height <= 115 {
                                        StickyPos1.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #1 (the yellow note)
                    TextEditor(text: $StickyText1)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos1)
                        // Changing the color for note #1 (the yellow note)
                        .colorMultiply(Color("StickyYellow"))
                    }
                }
            // The pink note
            if noteNumber >= 1{
                ZStack{
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos2)
                        // Changing the outline color for note #2 (the pink note)
                        .foregroundColor(Color("StickyPinkOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos2 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos2.width <= 77 {
                                        StickyPos2.width = 77
                                    }
                                    if StickyPos2.height <= 115 {
                                        StickyPos2.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #2 (the pink note)
                    TextEditor(text: $StickyText2)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos2)
                        // Changing the color for note #2 (the pink note)
                        .colorMultiply(Color("StickyPink"))
                }
            }
            // The purple note
            if noteNumber >= 2{
                ZStack {
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos3)
                        // Changing the outline color for note #3 (the purple note)
                        .foregroundColor(Color("StickyPurpleOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos3 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos3.width <= 77 {
                                        StickyPos3.width = 77
                                    }
                                    if StickyPos3.height <= 115 {
                                        StickyPos3.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #3 (the purple note)
                    TextEditor(text: $StickyText3)
                    // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos3)
                        // Changing the color for note #2 (the pink note)
                        .colorMultiply(Color("StickyPurple"))
                }
            }
            // The green note
            if noteNumber >= 3{
                ZStack {
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos4)
                        // Changing the outline color for note #4 (the green note)
                        .foregroundColor(Color("StickyGreenOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos4 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos4.width <= 77 {
                                        StickyPos4.width = 77
                                    }
                                    if StickyPos4.height <= 115 {
                                        StickyPos4.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #4 (the green note)
                    TextEditor(text: $StickyText4)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos4)
                        // Changing the color for note #4 (the green note)
                        .colorMultiply(Color("StickyGreen"))
                }
            }
        // The blue note
        if noteNumber >= 4{
            ZStack{
                // Creating a rectangle to serve as the note's outline
                Rectangle()
                    // Defining the note's size and position
                    .frame(width: 250,height: 250)
                    .offset(StickyPos5)
                    // Changing the outline color for note #5 (the blue note)
                    .foregroundColor(Color("StickyBlueOutline"))
                    // Making the note draggable
                    .gesture(
                        DragGesture()
                            .onChanged{value in withAnimation(.spring()) {
                                StickyPos5 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if StickyPos5.width <= 77 {
                                    StickyPos5.width = 77
                                }
                                if StickyPos5.height <= 115 {
                                    StickyPos5.height = 115
                                }
                            }
                        }
                    )
                // Creating the editable text box for sticky note #5 (the blue note)
                TextEditor(text: $StickyText5)
                    // Defining the note's size and position
                    .frame(width: 225, height: 225)
                    .offset(StickyPos5)
                    // Changing the color for note #5 (the blue note)
                    .colorMultiply(Color("StickyBlue"))
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
// Home page buttons extension preview
private extension ContentView{
    var HomePageButtons: some View{
        GeometryReader { geometry in
            // Creating the first button for the Home page
            // Creating a object that serves as the button border
            Rectangle()
                .cornerRadius(15)
                // Defining the object size
                .frame(width: 93, height: 93)
                // Defining the object colour
                .foregroundColor(.white)
                // Defining the object position
                .position(x:58, y:168)
            
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
                // Defining the object size
                .frame(width: 90, height: 90)
                // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                .position(x:58, y:168)
            
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
                
            // Creating the second button for the Home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
            // Defining the object size
                .frame(width: 90, height: 90)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:58, y:267)
            
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
            
            // Creating the third button for the Home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
            // Defining the object size
                .frame(width: 90, height: 90)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:58, y:366)
            
            // Defining button actions to change page
            Button(action: {
                currentPage = 2
            }) {
                // Adding and resizing the icon that the button will present as
                Image("StickiesIcon")
                    // Resizing the icon image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:366)
            
            // Creating the fourth button for the Home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
            // Defining the object size
                .frame(width: 90, height: 90)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:58, y:465)
            
            // Defining button actions to change page
            Button(action: {
                currentPage = 3
            }) {
                // Adding and resizing the icon that the button will present as
                Image("MapIcon")
                    // Resizing the icon image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:465)
            
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
                    if noteNumber >= 5 {
                        noteNumber = 0
                    }
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
                // Creating the button which saves the file information of the Sticky note text
                Button(action: {
                    // Saving the files
                    writeFile(Filename: "StickyText1", Data: StickyText1)
                    writeFile(Filename: "StickyText2", Data: StickyText2)
                    writeFile(Filename: "StickyText3", Data: StickyText3)
                    writeFile(Filename: "StickyText4", Data: StickyText4)
                    writeFile(Filename: "StickyText5", Data: StickyText5)
                    //reading the amount of data
                    let stickyData1 = readingFile(inputFile: "StickyText1")
                    let stickyData2 = readingFile(inputFile: "StickyText2")
                    let stickyData3 = readingFile(inputFile: "StickyText3")
                    let stickyData4 = readingFile(inputFile: "StickyText4")
                    let stickyData5 = readingFile(inputFile: "StickyText5")
                    // Printing the amount of data added to the console
                    print(stickyData1)
                    print(stickyData2)
                    print(stickyData3)
                    print(stickyData4)
                    print(stickyData5)
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Save")
                        // Resizing the icon image
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:37, y:310)
            }
        }
    }
    // Changing the size and position of the General notes TextEditor
private extension ContentView {
    var textEditorView: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width * 0.855, height: 570)
                .position(x: geometry.size.width * 0.54, y: 390)
                .foregroundColor(.black)
            TextEditor(text: $GeneralNoteText)
                .frame(width: geometry.size.width * 0.85, height: 565)
                .position(x: geometry.size.width * 0.54, y: 390)
            }
        }
    }
//  MindMap page buttons extension preview
private extension ContentView{
    var MindMapButtons: some View{
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
                .position(x:37, y:200)
            
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
                    .position(x:38, y:200)
            
            // Button to create a new mind map tile
            // Defining the object for button background
            Rectangle()
                .cornerRadius(10)
            // Defining the object size
                .frame(width: 60, height: 60)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:37, y:275)
            
            // Defining button actions to add a mind map tile
            Button(action: {
                TileAmount += 1
                if TileAmount >= 8 {
                    TileAmount = 0
                }
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
                    .position(x:38, y:275)
            
            
            // Creating the button which saves the file information of the mind map text
            Button(action: {
                // Saving the files 😁
                writeFile(Filename: "MindMapTitle", Data: MindMapTitleStr)
                writeFile(Filename: "MindMapStr1", Data: MindMapStr1)
                writeFile(Filename: "MindMapStr2", Data: MindMapStr2)
                writeFile(Filename: "MindMapStr3", Data: MindMapStr3)
                writeFile(Filename: "MindMapStr4", Data: MindMapStr4)
                writeFile(Filename: "MindMapStr5", Data: MindMapStr5)
                writeFile(Filename: "MindMapStr6", Data: MindMapStr6)
                writeFile(Filename: "MindMapStr7", Data: MindMapStr7)
            }) {
                // Adding and resizing the icon that the button will present as
                Text("Save")
                    // Resizing the icon image
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .background(Color("DarkOrange"))
                    .cornerRadius(10)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:37, y:350)
        }
    }
}

// Mind map page title (orange square)
private extension ContentView{
    var MindMapTitle: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("MapTitleOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapTitlePos)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapTitlePos = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapTitlePos.width <= 77 {
                                    MindMapTitlePos.width = 77
                                }
                                if MindMapTitlePos.height <= 132 {
                                    MindMapTitlePos.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map title square
                TextEditor(text: $MindMapTitleStr)
                    // Defining the note's size and position
                    .frame(width: 80,height:80)
                    .offset(MindMapTitlePos)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("NormOrange"))
                
            }
        }
    }
}

// Mind map page for tile 1
private extension ContentView{
    var MindMapTile1: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos1)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos1 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos1.width <= 77 {
                                    MindMapPos1.width = 77
                                }
                                if MindMapPos1.height <= 132 {
                                    MindMapPos1.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr1)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos1.width, y:MindMapPos1.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos1.width, y:MindMapPos1.height + 45)
            }
        }
    }
}

// Mind map page for tile 2
private extension ContentView{
    var MindMapTile2: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos2)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos2 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos2.width <= 77 {
                                    MindMapPos2.width = 77
                                }
                                if MindMapPos2.height <= 132 {
                                    MindMapPos2.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr2)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos2.width, y:MindMapPos2.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos2.width, y:MindMapPos2.height + 45)
            }
        }
    }
}

// Mind map page for tile 3
private extension ContentView{
    var MindMapTile3: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos3)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos3 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos3.width <= 77 {
                                    MindMapPos3.width = 77
                                }
                                if MindMapPos3.height <= 132 {
                                    MindMapPos3.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr3)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos3.width, y:MindMapPos3.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos3.width, y:MindMapPos3.height + 45)
            }
        }
    }
}

// Mind map page for tile 4
private extension ContentView{
    var MindMapTile4: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos4)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos4 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos4.width <= 77 {
                                    MindMapPos4.width = 77
                                }
                                if MindMapPos4.height <= 132 {
                                    MindMapPos4.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr4)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos4.width, y:MindMapPos4.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos4.width, y:MindMapPos4.height + 45)
            }
        }
    }
}

// Mind map page for tile 5
private extension ContentView{
    var MindMapTile5: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos5)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos5 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos5.width <= 77 {
                                    MindMapPos5.width = 77
                                }
                                if MindMapPos5.height <= 132 {
                                    MindMapPos5.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr5)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos5.width, y:MindMapPos5.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos5.width, y:MindMapPos5.height + 45)
            }
        }
    }
}

// Mind map page for tile 6
private extension ContentView{
    var MindMapTile6: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos6)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos6 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos6.width <= 77 {
                                    MindMapPos6.width = 77
                                }
                                if MindMapPos6.height <= 132 {
                                    MindMapPos6.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr6)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos6.width, y:MindMapPos6.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos6.width, y:MindMapPos6.height + 45)
            }
        }
    }
}

// Mind map page for tile 7
private extension ContentView{
    var MindMapTile7: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 125)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos7)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos7 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos7.width <= 77 {
                                    MindMapPos7.width = 77
                                }
                                if MindMapPos7.height <= 132 {
                                    MindMapPos7.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr7)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos7.width, y:MindMapPos7.height - 12.5)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
                // Defining button actions add mindmap tiles
                Button(action: {
                    TileAmount += 1
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .offset(x:MindMapPos7.width, y:MindMapPos7.height + 45)
            }
        }
    }
}

private extension ContentView{
    var PageOutline: some View{
        GeometryReader { geometry in
            VStack{
                // Creating the side bar for every page other than the home page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width:155, height: 6000)
                // Defining the object colour
                    .foregroundColor(Color("NormOrange"))
                // Defining the object position
                    .position(x: -1, y: 0)
                
                // Creating the top bar for the Home Page i love men
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
                    .position(x: geometry.size.width*0.955, y: 22)
            }
        }
    }
}
