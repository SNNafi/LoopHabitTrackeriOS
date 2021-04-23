//
//  HabitList.swift
//  LoopHabitTracker
//
//  Created by Shahriar Nasim Nafi on 23/4/21.
//

import Foundation

protocol HabitList {
    var filter: HabitMatcher { get set }
    var primaryOrder: Order { get set }
    var secondaryOrder: Order { get set }
    var isEmpty: Bool { get set }
    /// Returns the number of habits in this list.
    var count: Int { get set }
    
    /**
     Inserts a new habit in the list.
     
     If the id of the habit is null, the list will assign it a new id, which is guaranteed to be unique in the scope of the list. If id is not null, the caller should make sure that the list does not already contain another habit with same id, otherwise a `Error` will be thrown.
     - Parameter habit: the habit to be inserted
     - Throws: `HabitError.duplicateHabit` if the habit is already on the list.
     */
    func add(habit: Habit) throws
    
    /**
     Returns the habit with specified id.
     
     - Parameter id: the id of the habit
     - Returns: the habit, or `nil` if none exist
     */
    func getById(id: Int) -> Habit?
    
    /**
     Returns the habit with specified uuid.
     
     - Parameter uuid: the `UUID` of the habit
     - Returns: the habit, or `nil` if none exist
     */
    func getByUUID(uuid: UUID) -> Habit?
    
    /**
     Returns the habit that occupies a certain position.
     
     - Parameter position: the position of the desired habit
     - Returns: the habit at that position
     - Throws: `HabitError.positionOutOfIndex` when the position is invalid
     */
    func getByPosition(position: Int) throws -> Habit
    
    /**
     Returns the list of habits that match a given condition.
     
     - Parameter matcher: the matcher that checks the condition
     - Returns: the list of matching habits
     */
    func getFiltered(matcher: HabitMatcher?) -> HabitList
    
    /**
     Returns the index of the given habit in the list, or -1 if the list does not contain the habit..
     
     - Parameter habit: the habit
     - Returns: the index of the habit, or -1 if not in the list
     */
    func indexOf(habit: Habit) -> Int
    
    /**
     Removes the given habit from the list.
     
     - Parameter habit: the habit to be removed
     */
    func remove(habit: Habit)
    
    /// Removes all the habits from the list.
    func removeAll()
    
    /**
     Changes the position of a habit in the list.
     
     - Parameter from: the habit that should be moved
     - Parameter to:  the habit that currently occupies the desired position
     */
    func reorder(from: Habit, to: Habit)
    
    func repair()
    
    /**
     Notifies the list that a certain list of habits has been modified.
     
     Depending on the implementation, this operation might trigger a write to disk, or do nothing at all. To make sure that the habits get persisted, this operation must be called.
     
     - Parameter habits:the list of habits that have been modified
     */
    func update(habits: [Habit])
    
    /**
     Notifies the list that a certain habit has been modified
     
     Depending on the implementation, this operation might trigger a write to disk, or do nothing at all. To make sure that the habitsget persisted, this operation must be called.
     
     - Parameter habit:the habit that has been modified
     */
    func update(habit: Habit)
    
    /**
     Writes the list of habits to the given writer, in CSV format.
     
     There is  one line for each habit, containing the fields name, description,  frequency numerator, frequency denominator and color. The color is written in HTML format (#000000).
     
     - Parameter out:the writer that will receive the result
     - Throws: `HabitError.csvWritingFailed` if write operations fail
     */
    func writeCSV<T: Any>(out: T)
    
    func resort()
    
}


