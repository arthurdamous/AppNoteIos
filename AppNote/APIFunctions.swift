//
//  APIFunctions.swift
//  AppNote
//
//  Created by Arthur Damous on 01/02/21.
//

import Foundation
import Alamofire

struct Note: Decodable{
    var title:String
    var date:String
    var _id:String
    var note:String
}

class APIFunctions{
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchNotes(){
        AF.request("http://127.0.0.1:5000/fetch").response { response  in
            let data = String(data: response.data!, encoding: .utf8)
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func addNote(title:String, note:String, date:String){
        AF.request("http://127.0.0.1:5000/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date]).responseJSON {
            response in
        }
    }
    
    func updateNote(date: String, title: String, note: String, id:String ){
        AF.request("http://127.0.0.1:5000/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date, "id": id]).responseJSON{
            response in
            print(response)
        }
    }
    
    func deleteNote( id:String ){
        AF.request("http://127.0.0.1:5000/delete", method: .post,
                   encoding: URLEncoding.httpBody, headers: [ "id": id] ).responseJSON{
                    response in
                    print(response)
                   }
    }
    
}
