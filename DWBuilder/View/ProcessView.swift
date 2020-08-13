//
//  ProcessView.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/13.
//

import SwiftUI

enum ProcessStatus {
    case Processing
    case Failed(String)
    case Succeeded
}

struct ProcessView: View {
    let processStatus: ProcessStatus
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        switch self.processStatus {
            case .Processing:
                HStack {
                    Text("Processing")
                        .font(.headline)
                    ProgressView()
                }
            case .Succeeded:
                VStack {
                    Text("Success")
                        .font(.headline)
                    Button(action: self.onOKButtonPressed) {
                        Text("OK")
                    }
                }
            case .Failed(let reason):
                VStack {
                    Text(reason)
                        .font(.headline)
                    Button(action: self.onOKButtonPressed) {
                        Text("OK")
                    }
                }
        }
    }
    
    func onOKButtonPressed() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ProcessView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessView(processStatus: .Succeeded)
    }
}
