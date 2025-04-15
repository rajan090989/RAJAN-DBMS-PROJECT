
-- Query 1: List all active members with their membership type
SELECT member_id, first_name, last_name, membership_type
FROM Members
WHERE active_status = TRUE;

-- Query 2: List all books with fewer than 2 available copies
SELECT book_id, title, available_copies
FROM Books
WHERE available_copies < 2;

-- Query 3: Get all overdue loans (not yet returned and past due date)
SELECT Loans.loan_id, Members.first_name, Members.last_name, Books.title, due_date
FROM Loans
JOIN Members ON Loans.member_id = Members.member_id
JOIN Books ON Loans.book_id = Books.book_id
WHERE return_date IS NULL AND due_date < CURDATE();

-- Query 4: Show all members who have unpaid fines
SELECT DISTINCT Members.member_id, first_name, last_name, email
FROM Members
JOIN Fines ON Members.member_id = Fines.member_id
WHERE paid_status = FALSE;

-- Query 5: Find the top 5 most borrowed books
SELECT Books.title, COUNT(Loans.loan_id) AS times_borrowed
FROM Books
JOIN Loans ON Books.book_id = Loans.book_id
GROUP BY Books.book_id
ORDER BY times_borrowed DESC
LIMIT 5;

-- Query 6: Members who have borrowed more than 2 books
SELECT Members.member_id, first_name, last_name, COUNT(Loans.loan_id) AS total_loans
FROM Members
JOIN Loans ON Members.member_id = Loans.member_id
GROUP BY Members.member_id
HAVING total_loans > 2;

-- Query 7: List all books that have never been borrowed
SELECT book_id, title
FROM Books
WHERE book_id NOT IN (
    SELECT DISTINCT book_id FROM Loans
);

-- Query 8: Find members who joined in 2023
SELECT member_id, first_name, last_name, join_date
FROM Members
WHERE YEAR(join_date) = 2023;

-- Query 9: Get a count of members by membership type
SELECT membership_type, COUNT(*) AS total_members
FROM Members
GROUP BY membership_type;

-- Query 10: Find total fine amount paid by each member
SELECT Members.member_id, first_name, last_name, SUM(fine_amount) AS total_paid
FROM Members
JOIN Fines ON Members.member_id = Fines.member_id
WHERE paid_status = TRUE
GROUP BY Members.member_id;
