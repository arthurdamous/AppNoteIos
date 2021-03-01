//
//  AddNoteViewController.swift
//  AppNote
//
//  Created by Arthur Damous on 04/02/21.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    var note: Note?
    var update = false
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBAction func save(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: Date())
        
        if(update == true){
            APIFunctions.functions.updateNote(date: date, title:titleTextView.text!, note: bodyTextView.text!, id:note!._id)
            self.navigationController?.popViewController(animated: true)
        }else if titleTextView.text != "" && bodyTextView.text != ""{
            APIFunctions.functions.addNote(title: titleTextView.text!, note: bodyTextView.text, date: date)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        APIFunctions.functions.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(update == true){
            titleTextView.text = note?.title
            bodyTextView.text = note?.note
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false{
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
}
