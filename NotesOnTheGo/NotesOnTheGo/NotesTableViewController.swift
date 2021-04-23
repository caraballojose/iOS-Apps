//
//  NotesTableViewController.swift
//  NotesOnTheGo
//
//  Created by Jose Caraballo on 23/2/21.
//

import UIKit
import CoreData


class NotesTableViewController: UITableViewController {
    
    var notesArray = [Note]()
    
    var selectedCategory : Category?{
        didSet{
            loadNote()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Notes.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        tableView.delegate = self
        
      /*  if let previousNotes = userDefaults.array(forKey: "NoteArray") as? [Note]
        {
            self.notesArray = previousNotes
        }
        */
        self.navigationItem.title = selectedCategory?.title
        loadNote()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell

        let note = notesArray[indexPath.row]
        cell.titleCell.text = note.title
        
        if note.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.id = indexPath.row
        cell.delegate = self
        
        return cell
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let note = notesArray[indexPath.row]
        note.checked = (note.checked ? false : true )
        
        
        /* MARK : Borrado coredata
        context.delete(notesArray[indexPath.row])
        notesArray.remove(at: indexPath.row)
        */
        persistantNotes()
        
        //Con operador ternario
        tableView.cellForRow(at: indexPath)?.accessoryType = (note.checked ? .checkmark : .none)
        
        /*
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark 
        }
        */
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        print("Hemos pulsado el boton de la barra")
        
        var textField = UITextField()
        
        let controller = UIAlertController(title: "Nueva nota", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Agregar Item", style: .default) { (action) in
           
            let note = Note(context: self.context)
            note.title = textField.text!
            note.parentCategory = self.selectedCategory
            self.notesArray.append(note)
            
        //self.notesArray.append(textField.text!)
        //self.userDefaults.set(self.notesArray, forKey: "NoteArray")
            
            self.persistantNotes()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        controller.addAction(addAction)
        controller.addAction(cancelAction)
        
        controller.addTextField { (alerttexfield) in
            alerttexfield.placeholder = "Escribe aqui tu nota"
            textField = alerttexfield
            
        }
        
        present(controller, animated: true, completion: nil)
        
    }
    
    func persistantNotes() {
       
        do{
            try context.save()
        }catch{
            print("Error al guardar el contexto \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadNote(from request: NSFetchRequest<Note> = Note.fetchRequest(), predicate : NSPredicate? = nil) {
        
     
        let catPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
        
        if let previousPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [previousPredicate,catPredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = catPredicate
        }
        
        
        do {
            notesArray = try context.fetch(request)
        } catch {
            print("Error al consultar datos \(error)")
        }
        
        tableView.reloadData()
    }
    
}

extension NotesTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
       let searchText = searchBar.text!
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    
        
        let sortDescription = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescription]
        
        loadNote(from: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadNote()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}



extension NotesTableViewController: CellDelagate {
    
    func deleteCell(id: Int) {
        notesArray.remove(at: id)
        //self.userDefaults.set(self.notesArray, forKey: "NoteArray")
       // persistantNotes()
    }
    
    
}
