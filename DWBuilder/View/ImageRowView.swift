//
//  ImageRowView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/12.
//

import SwiftUI

struct ImageRowView: View {
    @Binding var imageMetadata: ImageMetadata
    @State var isSheetShown = false
    
    var body: some View {
        HStack {
            VStack {
                Text(self.imageMetadata.url.path)
                    .truncationMode(.middle)
                HStack {
                    Text(self.description(for: self.imageMetadata.latitude, position: self.imageMetadata.latitudePosition))
                    Text("Shot at \(UniversalDateFormatter.instance.string(from: self.imageMetadata.date))")
                }
            }
                .layoutPriority(1.0)
                .frame(maxWidth: .infinity)
            Button(action: {
                self.isSheetShown = true
            }) {
                Text("Modify")
            }
        }
            .sheet(isPresented: self.$isSheetShown) {
                ImageMetadataView(imageMetadata: self.$imageMetadata)
            }
    }
    
    func description(for latitude: Double, position: LatitudePosition) -> String {
        switch position {
            case .North: return String(format: NSLocalizedString("Latitude %.2f north", comment: ""), latitude)
            case .South: return String(format: NSLocalizedString("Latitude %.2f south", comment: ""), latitude)
        }
    }
}

struct ImageRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRowView(imageMetadata: .constant(ImageMetadata(url: URL(fileURLWithPath: "abcabcabcabcabcabcabcabcabc"), latitudePosition: .North, latitude: 30.0, date: Date())))
    }
}
