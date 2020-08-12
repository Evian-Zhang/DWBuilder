//
//  ContentView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ImageListView(imageMetadatas: self.$viewModel.imageMetadatas)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
