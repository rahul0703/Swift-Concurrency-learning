//
//  AsyncAwaitBootcamp.swift
//  Swift-Concurrency
//
//  Created by Rahul Sureka on 04/08/25.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
  @Published var dataArray: [String] = []
  
  func addTitle1() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.dataArray.append("Title 1: \(Thread.current)")
    }
  }
  
  func addTitle2() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      let title = "Title 2: \(Thread.current)"
      DispatchQueue.main.async {
        self.dataArray.append(title)
        
        let title3 = "Title 3: \(Thread.current)"
        self.dataArray.append(title3)
      }
    }
  }
  
  // Using async await
  func addAuthor1() async {
    let author = "Author 1: \(Thread.current)"
    self.dataArray.append(author)
  }
}

struct AsyncAwaitBootcamp: View {
  @StateObject private var viewModel = AsyncAwaitBootcampViewModel()
    var body: some View {
      List {
        // \.self is used to identify each element in the array using a hash value
        ForEach(viewModel.dataArray, id: \.self) { data in
          Text(data)
        }
      }
      .onAppear {
        //Task is needed to call async functions in SwiftUI
        Task {
          await viewModel.addAuthor1()
          
        }
//        viewModel.addTitle1()
//        viewModel.addTitle2()
      }
    }
}

#Preview {
    AsyncAwaitBootcamp()
}
