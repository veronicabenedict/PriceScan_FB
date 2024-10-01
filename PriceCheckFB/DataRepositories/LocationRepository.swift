// Created by Prof. H in 2022
// Part of the PriceCheckFB project
// Using Swift 5.0
// Qapla'


import Combine
// import Firebase modules here
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreCombineSwift



class LocationRepository: ObservableObject {
  // Set up properties here
  private let path: String = "location_scans"
  private let store = Firestore.firestore()
  
  @Published var locations: [Location] = []
  private var cancellables: Set <AnyCancellable> = []
  
  
  
  init() {
    self.get()
  }

  func get() {
    // Complete this function
    store.collection(path)
      .addSnapshotListener { QuerySnapshot, error in
        if let error = error {
          print("Error getting locations: \(error.localizedDescription)")
          return
        }
        
        self.locations = QuerySnapshot?.documents.compactMap {
          document in
          try? document.data(as: Location.self)
        } ?? []
      }
  }
}
