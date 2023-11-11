//
//  ContentView.swift
//  GIMMChat
//
//  Created by Sean McKenzie on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var userInput = ""
    @State var response = "Hello! How can I assist you today?"
    @State var isLoading = false
    
    
    var body: some View {
        VStack {
            Image(systemName: "face.smiling")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if (isLoading) {
                ProgressView()
            } else {
                ScrollView {
                    Text(response)
                }
            }
            
            Spacer()
            
            HStack {
                TextField("Tell me a joke...", text: $userInput)
                    .textFieldStyle(.roundedBorder)
                Button("Send", action: makePostRequest)
                    .disabled(isLoading)
            }
        }
        .padding()
    }
    
    
    func makePostRequest() {
        isLoading = true
        
        // Specify the URL of the API endpoint
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        // Create a dictionary with the data you want to send in the request body
        let requestData: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "system",
                    "content": "You are a friendly robot"
                ],
                [
                    "role": "user",
                    "content": userInput
                ]
            ]
        ]
        
        userInput = ""
        
        // Convert the parameters dictionary to JSON data
        let jsonData = try! JSONSerialization.data(withJSONObject: requestData)
        
        // Create a URLRequest with the specified URL
        var request = URLRequest(url: url)
        
        // Set the request method to POST
        request.httpMethod = "POST"
        
        // Set the request body with the JSON data
        request.httpBody = jsonData
        
        // Set the content type header to indicate JSON data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        // Create a URLSession task for the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response here
            
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                
                // Parse and handle the response data
                do {
                    let decoder = JSONDecoder()
                    let chatCompletion = try decoder.decode(ChatCompletion.self, from: data)
                    self.response = chatCompletion.choices[0].message.content
                } catch {
                    self.response = "Error decoding response: \(error)"
                }
            }
            
            // stop the spinner on the screen
            self.isLoading = false;
        }
        
        task.resume()
    }
}

#Preview {
    ContentView()
}
