//
//  ImageListView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import SwiftUI

struct ImageListView: View {
    @Binding var imageMetadatas: [ImageMetadata]
    
    var body: some View {
        VStack {
            Button(action: {}) {
                Image("plus")
            }
            if self.imageMetadatas.isEmpty {
                Text("Please click the above button to add some images")
            } else {
                List(self.imageMetadatas.indices, id: \.self) { index in
                    ImageRowView(imageMetadata: self.$imageMetadatas[index])
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ImageListView(imageMetadatas: .constant([
            ImageMetadata(url: URL(fileURLWithPath: "abc"), latitudePosition: .North, latitude: 30.0, date: Date()),
            ImageMetadata(url: URL(fileURLWithPath: "def"), latitudePosition: .North, latitude: 30.0, date: Date()),
            ImageMetadata(url: URL(fileURLWithPath: "ghi"), latitudePosition: .North, latitude: 30.0, date: Date()),
            ImageMetadata(url: URL(fileURLWithPath: "abcabcacbasdoeuasdef"), latitudePosition: .North, latitude: 30.0, date: Date())
        ]))
    }
}
