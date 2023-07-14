//
//  ContentView.swift
//  QRCode Generator
//
//  Created by Dilshad N on 17/09/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var name = ""
    @State private var email = ""
    
    let context = CIContext()
    let filter  = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    
                    Text("QR Code Generator")
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(.largeTitle, design: .rounded))
                        .padding()
                    
                    TextField("Enter Name", text: $name)
                        .textContentType(.name)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.regularMaterial))
                        .padding(.top, 50)
                    
                    
                    TextField("Enter Email", text: $email)
                        .textContentType(.emailAddress)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.regularMaterial))
                        .padding(.bottom, 50)
                    
                    
                    if !name.isEmpty && !email.isEmpty {
                        Image(uiImage: qrGenerator(from: "\(name)\n\(email)"))
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                    
                    
                    Spacer()
                    
                }
                
                .padding()
            }
        }
    }
    
    
    func qrGenerator(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let finalImage = filter.outputImage {
            if let image = context.createCGImage(finalImage, from: finalImage.extent) {
                return UIImage(cgImage: image)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
