//
//  ContentView.swift
//  GIMMChat
//
//  Created by Sean McKenzie on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var hey = "starting text"
    @State var isLoading = true
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(hey)
            if (isLoading) {
                ProgressView()
            }
        }
        .padding()
        .task {
//            let messages = [Message(content: "hello there", role: "you are a friendly bot")]
//            let testRequest = TestRequest(model: "gpt-3.5-turbo", messages: messages)
//            let url = URL(string: "https://api.openai.com/v1/chat/completions")!
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.httpBody = testRequest.encode(to: Data)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
            
            
            
            makePostRequest()
        }
    }
    
    
    func makePostRequest() {
        // Specify the URL of the API endpoint
            let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
            // Create a dictionary with the data you want to send in the request body
        let requestData: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    [
                        "role": "system",
                        "content": "You are a friendly robot."
                    ],
                    [
                        "role": "user",
                        "content": "Hello there."
                    ]
                ]
            ]

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
                        hey = chatCompletion.choices[0].message.content
                    } catch {
                        hey = "Error decoding response: \(error)"
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
