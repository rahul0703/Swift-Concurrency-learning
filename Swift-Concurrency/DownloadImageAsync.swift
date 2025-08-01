//
//  DownloadImageAsync.swift
//  Swift-Concurrency
//
//  Created by Rahul Sureka on 01/08/25.
//

import SwiftUI

/*
 What we are learning here?
 - First we learn how to download image using escaping closure and combine.
 - Then we learn how to download image using async await.
 */

class DownloadImageAsyncImageLoader {
  
  let url = URL(string: "https://picsum.photos/200")!
  
  func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
    // This function would typically handle the response from a network request.
    // It checks if the data is valid and if the response status code is in the 200 range.
    guard
      let data = data,
      let image = UIImage(data: data),
      let response = response as? HTTPURLResponse,
      response.statusCode >= 200 && response.statusCode < 300
    else {
      return nil
    }
    return image
  }
  
  func downloadwithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
    // This function would typically download an image asynchronously using a closure.
    
    // URLSession.shared.dataTask is an asynchronous method that fetches data from the specified URL.
    // Its returns data, response, and error in the completion handler.
    // This is a escaping closure because it is called after the function returns.
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      let image = self?.handleResponse(data: data, response: response)
      completionHandler(image, error)
    }
    .resume()
    //creates a task, but doesn’t start it. To actually execute the network call, you must call .resume():
  }
  
  
  //Download Image with Combine
  //Combine: A framework that provides a declarative Swift API for processing values over time.
  func downloadWithCombine() {
    URLSession.shared.dataTaskPublisher(for: url)
  }
}

class DownloadImageAsyncViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  let loader = DownloadImageAsyncImageLoader()
  
  func fetchImage() {
    loader.downloadwithEscaping { [weak self] image, error in
      //We added the image update in main thread because UIKit updates must be done on the main thread.
      //The operation URLSession.shared.dataTask is done on a background thread, so we need to switch back to the main thread to update the UI.
      DispatchQueue.main.async {
        self?.image = image
      }
    }
  }
}


struct DownloadImageAsync: View {
  @StateObject private var viewModel = DownloadImageAsyncViewModel()
  
    var body: some View {
      ZStack {
        if let image = viewModel.image {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
        }
      }
      .onAppear {
        viewModel.fetchImage()
      }
    }
}

#Preview {
    DownloadImageAsync()
}
