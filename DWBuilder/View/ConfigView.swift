//
//  ConfigView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/13.
//

import SwiftUI

struct ConfigView: View {
    @Binding var lightIndex: Int
    @Binding var darkIndex: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Display static light wallpaper at image ")
                TextField("light index", value: self.$lightIndex, formatter: UniversalImageIndexFormatter.instance)
                    .frame(maxWidth: 50)
            }
            HStack {
                Text("Display static dark wallpaper at image ")
                TextField("dark index", value: self.$darkIndex, formatter: UniversalImageIndexFormatter.instance)
                    .frame(maxWidth: 50)
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(lightIndex: .constant(0), darkIndex: .constant(0))
    }
}
