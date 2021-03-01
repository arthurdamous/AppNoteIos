//
//  ViewController.swift
//  AppNote
//
//  Created by Arthur Damous on 31/01/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notesArray = [Note]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        
        if(segue.identifier == "updateNoteSegue"){
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        print(notesArray)
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        return cell
    }
}

//MARK: - Custom Delegates

protocol DataDelegate {
    func updateArray(newArray:String)
}

extension ViewController: DataDelegate {
    
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
        }catch{
            print("failed to decode")
        }
        self.notesTableView.reloadData()
    }
    
}
