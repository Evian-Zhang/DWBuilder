//
//  ImageMetadataView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/12.
//

import SwiftUI

struct ImageMetadataView: View {
    @Binding var isPresented: Bool
    @Binding var imageMetadata: ImageMetadata
    
    var body: some View {
        VStack {
            Text(imageMetadata.url.pathComponents.last ?? "Unknown")
                .truncationMode(.middle)
            HStack {
                Picker("Latitude", selection: self.$imageMetadata.latitudePosition) {
                    Text("N").tag(LatitudePosition.North)
                    Text("S").tag(LatitudePosition.South)
                }
                    .pickerStyle(RadioGroupPickerStyle())
                TextField("latitude degree", value: self.$imageMetadata.latitude, formatter: UniversalLatitudeFormatter.instance)
                    .frame(maxWidth: 70.0)
            }
            HStack {
                DatePicker("Shot at", selection: self.$imageMetadata.date, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(StepperFieldDatePickerStyle())
                    .frame(maxWidth: 100.0)
            }
            Button(action: {
                self.isPresented = false
            }) {
                Text("OK")
            }
        }
    }
}

struct ImageMetadataView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMetadataView(isPresented: .constant(true), imageMetadata: .constant(ImageMetadata(url: URL(fileURLWithPath: "abcabcabcabcabcabcabcabcabc"), latitudePosition: .North, latitude: 30.0, date: Date())))
    }
}
