//
//  FirestoreManager.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    private var db = Firestore.firestore()
    //Profiles
    func createProfile(profile: ProfileModel, completion: @escaping (Bool, Error?) -> Void) {
        let data = profile.toFirestoreData()
        db.collection("Profiles").document(profile.id).setData(data) { error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func getProfile(withId id: String, completion: @escaping (ProfileModel?, Error?) -> Void) {
        db.collection("Profiles").document(id).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                let profile = ProfileModel(from: data)
                completion(profile, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    /*
    func updateProfile(profile: ProfileModel, completion: @escaping (Bool, Error?) -> Void) {
        let data = profile.toFirestoreData()
        db.collection("Profiles").document(profile.id).updateData(data) { error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    */
    func updateProfile(profile: ProfileModel, completion: @escaping (Bool, Error?) -> Void) {
        let data = profile.toFirestoreData()
        db.collection("Profiles").document(profile.id).setData(data, merge: true) { error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func getProfile(for userId: String, completion: @escaping (ProfileModel?, Error?) -> Void) {
        db.collection("Profiles").document(userId).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                let profile = ProfileModel(from: data)
                completion(profile, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    ///Registration verification code
    func getVerifier(for identifier: Int, completion: @escaping (Verifier?, Error?) -> Void) {
        let documentId = "\(identifier - 1)"
        db.collection("Verificadores").document(documentId).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let documentData = document?.data(),
               let identifierCiclista = documentData["IndetificadorCiclista"] as? String,
               let emailUser = documentData["emailUser"] as? String,
               let registered = documentData["registered"] as? Bool,
               let verifierCode = documentData["verificador"] as? String {
                
                let verifier = Verifier(identifierCiclista: identifierCiclista, emailUser: emailUser, registered: registered, verifierCode: verifierCode)
                completion(verifier, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func updateEmail(for identifier: Int, email: String, completion: @escaping (Error?) -> Void) {
        let documentId = "\(identifier - 1)"
        db.collection("Verificadores").document(documentId).updateData(["emailUser": email]) { error in
            completion(error)
        }
    }
    
    func markAsRegistered(for identifier: Int, completion: @escaping (Error?) -> Void) {
        let documentId = "\(identifier - 1)"
        db.collection("Verificadores").document(documentId).updateData(["registered": true]) { error in
            completion(error)
        }
    }
    
    //DatosRutas
    func fetchAllRides(completion: @escaping ([RideModel]?, Error?) -> Void) {
        print("Accessing Firestore...")
        //db.collection("MockDatosSalidasPrueba").getDocuments { (querySnapshot, error) in
        db.collection("MockDatosSalidasPrueba").getDocuments { (querySnapshot, error) in

            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            var rides: [RideModel] = []
            print("probando si entra")
            for document in querySnapshot!.documents {
                print("prbando si pasa")
                if let ride = RideModel(from: document.data()) {
                    print("ride")
                    rides.append(ride)
                } else {
                    print("Failed to parse document with ID: \(document.documentID)")
                }
            }

            
            // Ordenar las rutas por fecha
            rides.sort { $0.date < $1.date }
            
            completion(rides, nil)
        }
    }
    
    func fetchRideDetails(rideId: String, completion: @escaping (RideModel?, Error?) -> Void) {
        db.collection("MockDatosSalidasPrueba").document(rideId).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let documentData = document?.data(), let ride = RideModel(from: documentData) {
                completion(ride, nil)
            } else {
                completion(nil, nil)
            }
        }
    }



    ///SPONSOR
    func getSponsors(completion: @escaping ([SponsorModel]?, Error?) -> Void) {
        db.collection("sponsorsUCB").getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let documents = snapshot?.documents {
                let sponsors = documents.compactMap { SponsorModel(from: $0.data()) }
                completion(sponsors, nil)
            }
        }
    }
    ///NEWS
    func fetchAllNews(completion: @escaping ([NewsModel]?, Error?) -> Void) {
        db.collection("NewsUCB").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var news: [NewsModel] = []
            for document in querySnapshot!.documents {
                if let newsItem = NewsModel(from: document.data()) {
                    news.append(newsItem)
                }
            }
            
            completion(news, nil)
        }
    }
    
    ///CHECKING
    
    
    func saveCheckin(checkin: CheckingModel, completion: @escaping (Bool, Error?) -> Void) {
        let data = checkin.documentData
        db.collection("checkins").addDocument(data: data) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func getCheckins(for userId: String, completion: @escaping ([CheckingModel]?, Error?) -> Void) {
        db.collection("checkins").whereField("profileId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let checkins = snapshot?.documents.compactMap { CheckingModel(documentData: $0.data()) }
                completion(checkins, nil)
            }
        }
    }
    ///POINTSUCB
    func updatePoints(for userId: String, with score: Int, for rideId: String, completion: @escaping (Bool) -> Void) {
        let userPointsRef = db.collection("PointsUCB").document(userId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let userDocument: DocumentSnapshot
            do {
                try userDocument = transaction.getDocument(userPointsRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            let oldPoints = userDocument.data()?["totalPoints"] as? Int ?? 0
            let newPoints = oldPoints + score
            transaction.updateData(["totalPoints": newPoints], forDocument: userPointsRef)
            
            // Agrega un registro de la salida con los puntos
            let ridePointsData = ["rideId": rideId, "points": score, "date": FieldValue.serverTimestamp()] as [String : Any]
            transaction.setData(ridePointsData, forDocument: userPointsRef.collection("RidePoints").document())
            
            return nil
        }) { (object, error) in
            if let error = error {
                print("Transaction failed: \(error)")
                completion(false)
            } else {
                print("Transaction successfully committed!")
                completion(true)
            }
        }
    }
    ///POINTS
    // Método para obtener los puntos totales de un usuario
        func getTotalPoints(for userId: String, completion: @escaping (Int) -> Void) {
            let userPointsRef = db.collection("PointsUCB").document(userId)
            userPointsRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let totalPoints = document.data()?["totalPoints"] as? Int ?? 0
                    completion(totalPoints)
                } else {
                    // Manejar el caso en que no existan puntos o haya un error
                    completion(0)
                }
            }
        }

        // Método para obtener los puntos por salida de un usuario
        func getRidePoints(for userId: String, completion: @escaping ([PointsModel]) -> Void) {
            let userRidePointsRef = db.collection("PointsUCB").document(userId).collection("RidePoints")
            userRidePointsRef.getDocuments { (snapshot, error) in
                var pointsArray: [PointsModel] = []
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        if let pointsModel = PointsModel(from: document.data()) {
                            pointsArray.append(pointsModel)
                        }
                    }
                }
                // Devolver el array de puntos por salida
                completion(pointsArray)
            }
        }

    

    

}
