//
//  DoCatchTryThroughBootcamp.swift
//  Swift-Concurrency
//
//  Created by Rahul Sureka on 01/08/25.
//

import SwiftUI

//What are we learning here
//Do-catch statement
//try
//throw


class DocatchTryThrowBootcampDataManager {
  
  var isActive: Bool = false
  
  
  //This is not a ideal production level code as user is not informed about the error. Instead we can improve it by returning an error
  func getTitleBasic() -> String? {
    if isActive {
      return "New Title"
    } else {
      return nil
    }
  }
  
  //This is a better way to handle errors in Swift
  
  //There is a problem with this code as should not return value and error
  //both time. We should throw an error or return result if something goes wrong.
  func getTitle() -> (title: String?, error: Error?) {
    if isActive {
      return ("New Title", nil)
    } else {
      // In your prod application use a custom error but here we are using URLError for learning purpose.
      return (nil, URLError(.badURL))
    }
  }
  
  //Here is the improved version of the above code
  func getTitle2() -> Result<String, Error> {
    
  }
  
  
}


/*
 Def ObservableObject:
  - ObservableObject is a protocol that allows SwiftUI views to observe changes in data.
 Layman Def: Imagine you have a whiteboard that shows some information — like a user's name.
             Now, suppose this whiteboard is shown to many people (views). If someone changes the name,
             everyone looking at the whiteboard should see the updated name instantly.
             In SwiftUI, this whiteboard is a class marked as ObservableObject.
 */
class DocatchTryThrowBootcampViewModel: ObservableObject {
  /*
   @Published is a property wrapper that allows you to mark properties in an ObservableObject
   */
  @Published var text: String = "Starting Text"
  
  //Although we should do it dependency injection but here so simplicity we are creating the instance directly
  let manager = DocatchTryThrowBootcampDataManager()

  func fetchTitle() {
    let returnedValue = manager.getTitle()
    if let newTitle = returnedValue.title {
      self.text = newTitle
    } else if let error = returnedValue.error {
      self.text = error.localizedDescription
    }
  }

}

struct DoCatchTryThroughBootcamp: View {
  /*
   @stateObject is a property wrapper that allows you to create an instance of an ObservableObject
   @observedObject is a property wrapper that allows you to observe changes to an ObservableObject instance
   
   Diff b/w stateObject and observedObject:
   @StateObject and @ObservedObject are both property wrappers in SwiftUI used to observe changes to an ObservableObject.
   However, they differ in how they handle the lifecycle of the observed object.
   @StateObject is used when the view owns the object, ensuring its persistence across view updates.
   @ObservedObject is used when the view receives the object from an external source, and SwiftUI doesn't manage its lifecycle
   */
    @StateObject var viewModel = DocatchTryThrowBootcampViewModel()
  
    var body: some View {
      Text(viewModel.text)
        .frame(width: 300, height: 300)
        .background(Color.blue)
        .onTapGesture {
          viewModel.fetchTitle()
        }
    }
}

#Preview {
  DoCatchTryThroughBootcamp()
}
