//
//  ViewController.swift
//  MathTraining
//
//  Created by Jose Caraballo on 15/2/21.
//

import UIKit
import Vision

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var drawingView: DrawingImageView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    let factory = QuestionFactory()

    var mnistModel = MnistModel()
    
    var gameTimer : Timer!
   
    var totalTime = 60
    
    var timeLeft : Int = 0
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawingView.delegate = self 
        
        title = "Math Training"
        tableView.layer.borderColor = UIColor.green.cgColor
        tableView.layer.borderWidth = 5
        
        self.timeLeft = self.totalTime
        
        self.progressView.progress = 1.0
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timeLeft -= 1
            self.progressView.progress = Float(self.timeLeft) / Float(self.totalTime)
        })
             
               
    }
    
    func numberDraw(_ image: UIImage){
       
        //1. Resize the Image to 299 x 299
        let modelSize = 299
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: modelSize, height: modelSize), true, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: modelSize, height: modelSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //2. UIimage -> CG
        
        guard let ciimage = CIImage(image: newImage) else {
            fatalError("Error al covertir de UIimage a CGImage")
        }
        //3. cargar el modelo de Vision
        
        guard let model = try? VNCoreMLModel(for: mnistModel.model) else {
            fatalError("NO se ha podido preparar e modelo para Vision")
        }
        
        //4. Peticion
        
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
             
            
            guard let results = request.results as?  [VNClassificationObservation],
                  let prediction = results.first else {
                fatalError("Error al hacer la prediccion \(error?.localizedDescription ?? "Error desconocido")")
            }
            
            DispatchQueue.main.async {
                let result = Int(prediction.identifier) ?? 0
                // asignamos respuesta a pregunta actual
                self?.factory.updateQuestion(at: 0, with: result)
                self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                self?.factory.validateQuestion(at: 0)
                // crear nueva
                self?.askNewQuestion()
            
                
            }
            
        }
        
        //6  Juntar todo
        
        let handler = VNImageRequestHandler(ciImage: ciimage)
     
        //Ejecutamos la predicion en un hilo secundario
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }

    func askNewQuestion() {
        drawingView.image = nil
        
        if timeLeft > 0 {
            
            factory.addNewQuestion()
            
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .right)
            
            let secondIndexPath = IndexPath(row: 1, section: 0)
            if let cell = tableView.cellForRow(at: secondIndexPath), let question = factory.getQuestion(position: 1) {
                setText(for: cell, at: secondIndexPath, to: question)
            }
        } else {
            
            gameTimer.invalidate()
            
            let controller = UIAlertController(title: "Game Over", message: "Has Obtenido: \(factory.score) puntos.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Intentar de nuevo", style: .default, handler: restarGame)
            controller.addAction(action)
            present(controller, animated: true)
        }
        
        
    }// end New Question
    
    func restarGame(action: UIAlertAction) {
        factory.restarGame()
        self.tableView.reloadData()
        
        self.timeLeft = self.totalTime
        self.progressView.progress = 1.0
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timeLeft -= 1
            self.progressView.progress = Float(self.timeLeft) / Float(self.totalTime)
        })
        
    }
    
    
    func setText(for cell: UITableViewCell, at indexPath: IndexPath, to question: Question) {
        if indexPath.row == 0 {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 36)
            
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            
            if  question.answer == question.userAnswer {
                cell.backgroundColor = UIColor(red: 0.3, green: 1.0, blue: 0.2, alpha: 0.7)
            }else {
                cell.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 0.7)
            }
            
        }
        
        if let userAnswer = question.userAnswer {
            cell.textLabel?.text = "\(question.text) = \(userAnswer)"
        } else {
            cell.textLabel?.text = "\(question.text) = ?"
        }
        
    }
    
    //Metodos source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factory.getNumberOfQuestion()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let currentQuestion = factory.getQuestion(position: indexPath.row){
           setText(for: cell, at: indexPath, to: currentQuestion)
        }
        
        return cell
        
    }
    
    //Methods Delagates
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

