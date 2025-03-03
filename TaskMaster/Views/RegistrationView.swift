//
//  RegistrationView.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/3/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var controller = RegisterController()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Capsule()
                    .stroke(Color.green, lineWidth: 75)
                    .frame(width: geometry.size.width + 100 , height: geometry.size.height + 200)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2.0)
                    .offset(x: 0, y: 50)
                    .ignoresSafeArea()
                VStack {
                    Text("Get Started with")
                        .font(.system(size: 34, weight: .regular, design: .default))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primary)
                        .padding(.top, 40)
                        .padding([.leading, .trailing], 10)
                    
                    Text("Do the Things")
                        .font(.system(size: 50, weight: .heavy, design: .default))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.primary)
                        .padding(.bottom, 30)
                        .padding([.leading, .trailing], 10)
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(Color.green, Color.black)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.green, lineWidth: 15))
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Full Name")
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                            .padding(.bottom, -10)
                        
                        TextField("", text: $controller.fullname)
                            .autocorrectionDisabled()
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 10) //Spacing for text, not the field
                            .frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
                            .foregroundColor(Color.inverse)
                            .background(Color.primary)
                            .cornerRadius(10)
                        
                        Text("Email Address")
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                            .padding(.bottom, -10)
                        TextField("", text: $controller.email)
                            .autocorrectionDisabled()
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 10) //Spacing for text, not the field
                            .frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
                            .foregroundColor(Color.inverse)
                            .background(Color.primary)
                            .cornerRadius(10)
                        
                        Text("Password")
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                            .padding(.bottom, -10)
                        SecureField("", text: $controller.password)
                            .autocorrectionDisabled()
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 10) //Spacing for text not the field
                            .frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
                            .foregroundColor(Color.inverse)
                            .background(Color.primary)
                            .cornerRadius(10)
                    }
                    .padding([.leading, .trailing], 35)
                    
                    if !controller.error.isEmpty {
                        Text(controller.error)
                            .foregroundStyle(Color.red)
                    }
                    
                    Button("Register") {
                        controller.register()
                    }
                        .font(.headline)
                        .foregroundColor(Color.inverse)
                        .frame(width: 250, height: 50)
                        .background(Color.primary)
                        .cornerRadius(15.0)
                        .padding(10)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 25)
                // Make the VStack take the full size of the GeometryReader
                .frame(width: geometry.size.width, height: geometry.size.height)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}

#Preview {
    RegistrationView()
}
