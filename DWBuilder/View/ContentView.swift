//
//  ContentView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var isProcessSheetPresented = false
    @State var processStatus: ProcessStatus = .Processing
    
    var body: some View {
        VSplitView {
            ImageListView(imageMetadatas: self.$viewModel.imageMetadatas)
            VStack {
                ConfigView(lightIndex: self.$viewModel.lightIndex, darkIndex: self.$viewModel.darkIndex)
                Button(action: self.exportImage) {
                    Text("Export")
                }
            }
                .sheet(isPresented: self.$isProcessSheetPresented) {
                    ProcessView(processStatus: self.processStatus)
                }
            .frame(maxWidth: .infinity)
        }
    }
    
    func exportImage() {
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.nameFieldStringValue = "Untitled.heic"
        savePanel.allowedFileTypes = ["heic"]
        savePanel.allowsOtherFileTypes = false
        savePanel.isExtensionHidden = false
        
        if (savePanel.runModal() == .OK) {
            guard let url = savePanel.url else { return }
            self.processStatus = .Processing
            self.isProcessSheetPresented = true
            let queue = UniversalDispatchQueue.instance
            queue.async {
                do {
                    let imageData = try self.viewModel.exportImage()
                    try imageData.write(to: url)
                    DispatchQueue.global().sync {
                        self.processStatus = .Succeeded
                    }
                } catch DWBuilderError.PropertyListEncodingFailed {
                    DispatchQueue.global().sync {
                        self.processStatus = .Failed("Property list encoding failed")
                    }
                } catch DWBuilderError.ImageNotFound(let url) {
                    DispatchQueue.global().sync {
                        self.processStatus = .Failed("Can't open image at \(url)")
                    }
                } catch DWBuilderError.HEICCreatingFailed {
                    DispatchQueue.global().sync {
                        self.processStatus = .Failed("Failed to create HEIC image")
                    }
                } catch {
                    DispatchQueue.global().sync {
                        self.processStatus = .Failed("Failed to write image")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
