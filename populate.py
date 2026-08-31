import sqlite3
import datetime
import random

# Colors in ARGB
COLORS = [4294198070, 4283215696, 4280391411, 4294940672, 4288585374]

def main():
    conn = sqlite3.connect('taskly.db')
    c = conn.cursor()

    # Clear existing tasks for clean demo
    c.execute('DELETE FROM tasks')
    
    now = datetime.datetime.now()
    
    tasks_data = [
        # Overdue tasks
        ("Fix critical bug in payment gateway", "The payment API is failing for 5% of transactions. Needs urgent investigation.", 2, now - datetime.timedelta(days=2), 0),
        ("Submit quarterly tax report", "Compile all receipts and send to accountant.", 1, now - datetime.timedelta(days=1), 0),
        
        # Today's tasks
        ("Team Sync Meeting", "Weekly sync with the remote team to discuss sprint progress.", 1, now, 0),
        ("Review pull requests", "Go through pending PRs in the frontend repo.", 1, now, 0),
        ("Buy groceries", "Milk, Eggs, Bread, and Coffee beans.", 0, now, 0),
        ("Call Mom", "Wish her a happy birthday!", 2, now, 1),
        ("Workout", "Leg day at the gym.", 0, now, 1),
        
        # Tomorrow
        ("Dentist Appointment", "Routine checkup at Dr. Smith's clinic.", 2, now + datetime.timedelta(days=1), 0),
        ("Write blog post draft", "Topic: State Management in Flutter.", 1, now + datetime.timedelta(days=1), 0),
        ("Update server SSL certificates", "Certificates expiring next week, update them now to be safe.", 2, now + datetime.timedelta(days=1), 0),
        
        # Next few days
        ("Plan weekend trip", "Look up hotels and flights for the upcoming long weekend.", 0, now + datetime.timedelta(days=2), 0),
        ("Pay electricity bill", "Amount: $120. Due on the 5th.", 1, now + datetime.timedelta(days=3), 0),
        ("Finish reading book", "'Clean Architecture' by Robert C. Martin.", 0, now + datetime.timedelta(days=4), 0),
        ("Car maintenance", "Oil change and tire rotation.", 1, now + datetime.timedelta(days=5), 0),
        
        # Completed tasks
        ("Setup development environment", "Install Flutter, Android Studio, and configure emulators.", 2, now - datetime.timedelta(days=5), 1),
        ("Design app logo", "Create vector assets for the new project.", 1, now - datetime.timedelta(days=4), 1),
        ("Draft project proposal", "Write executive summary and cost estimates.", 2, now - datetime.timedelta(days=3), 1),
        ("Client kickoff call", "Initial meeting to discuss requirements.", 2, now - datetime.timedelta(days=2), 1),
        ("Update resume", "Add recent projects and skills.", 1, now - datetime.timedelta(days=1), 1),
        
        # Far future
        ("Renew passport", "Expires in 6 months, start the application process.", 2, now + datetime.timedelta(days=14), 0),
    ]
    
    for title, desc, priority, due_date, is_done in tasks_data:
        color = random.choice(COLORS)
        create_time = now - datetime.timedelta(days=random.randint(1, 10))
        
        c.execute('''
            INSERT INTO tasks (userId, title, description, colorValue, priority, createTime, dueDate, isDone)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (1, title, desc, color, priority, create_time.isoformat(), due_date.isoformat(), is_done))
        
    conn.commit()
    conn.close()
    print("Inserted 20 tasks successfully.")

if __name__ == '__main__':
    main()
