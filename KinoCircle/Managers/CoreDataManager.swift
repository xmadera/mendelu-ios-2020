//
//  CoreDataManager.swift
//  KinoCircle
//
//  Created by Jan Madera on 05/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func getMovies() -> [MovieCD] {
        
        var movies = [MovieCD]()
        
        let movieRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        
        do  {
            movies = try self.moc.fetch(movieRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return movies
        
    }
    
    func removeMovie(at offsets: IndexSet) {
        
        var movies = self.getMovies()
        
        for index in offsets {
            let movie = movies[index]
            moc.delete(movie)
        }
    }
}

