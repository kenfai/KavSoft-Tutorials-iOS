//
//  ContentView.swift
//  FileImportExport
//
//  Created by Ginger on 19/12/2020.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var fileName = ""
    @State var openFile = false
    @State var saveFile = false
    
    var body: some View {
        VStack(spacing: 25) {
            Text(fileName)
                .fontWeight(.bold)
            
            Button(action: {
                openFile.toggle()
            }) {
                Text("Open")
            }
            
        
        Button(action: {
            saveFile.toggle()
        }) {
            Text("Save")
        }
        }
        // any file you want
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.png]) { (result) in
            do {
                let fileUrl = try result.get()
                
                print(fileUrl)
                
                // Getting filename
                self.fileName = fileUrl.lastPathComponent
            } catch {
                print("Error reading docs")
                print(error.localizedDescription)
            }
        }
        // to save file
        .fileExporter(isPresented: $saveFile, document: Doc(url: Bundle.main.path(forResource: "audio", ofType: "mp3")!), contentType: .audio) { (result) in
            do {
                let fileUrl = try result.get()
                
                print(fileUrl)
            } catch {
                print("Error saving doc")
                print(error.localizedDescription)
            }
        }
    }
}

struct Doc: FileDocument {
    var url: String
    static var readableContentTypes: [UTType]{[.audio]}
    
    init(url: String) {
        self.url = url
    }
    
    init(configuration: ReadConfiguration) throws {
        // desetilize the content
        // we do not need to read contents
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        // returning and saving file
        let file = try! FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
        
        return file
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
