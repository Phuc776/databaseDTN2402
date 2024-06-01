-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban
-- của họ
SELECT * FROM account
INNER JOIN department USING (department_id);
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày
-- 20/12/2010
SELECT * FROM account
INNER JOIN department USING(department_id)
INNER JOIN `position` USING(position_id)
WHERE created_date > "2010-12-20";
-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT * FROM account
INNER JOIN `position` USING(position_id)
WHERE position_name = "Dev";
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT department.*, COUNT(account_id) as num_of_emps
FROM account
INNER JOIN department USING(department_id)
GROUP BY department_id
HAVING COUNT(account_id) > 3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi
-- nhiều nhất
SELECT question.*, Count(exam_id) FROM question
LEFT JOIN exam_question USING (question_id)
GROUP BY question_id
ORDER BY Count(exam_id) desc;	
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu
-- Question
SELECT category_question.*,COUNT(question_id) FROM question
RIGHT JOIN category_question USING(category_id)
GROUP BY category_id;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT question.*, Count(exam_id) FROM question
LEFT JOIN exam_question USING (question_id)
GROUP BY question_id;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT question.*,COUNT(answer_id) FROM answer
INNER JOIN question USING (question_id)
GROUP BY answer.question_id
ORDER BY COUNT(answer_id) DESC
LIMIT 1;
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT `Group`.*, Count(account_id) FROM `Group`
LEFT JOIN group_account USING (group_id)
GROUP BY group_id;
-- Question 10: Tìm chức vụ có ít người nhất
SELECT position.*,COUNT(account_id) FROM position
INNER JOIN account USING(position_id)
GROUP BY position_id
ORDER BY COUNT(account_id) ASC
LIMIT 1;
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum
-- master, PM
SELECT department_name,position_name, COUNT(account_id)
FROM department
CROSS JOIN position
LEFT JOIN account USING (department_id, position_id)
GROUP BY department_id, position_id;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản
-- của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

-- Question 14:Lấy ra group không có account nào
-- Question 15: Lấy ra group không có account nào
-- Question 16: Lấy ra question không có answer nào.

-- 2. Union.
-- Question 17:

-- Training Assignments

-- 3
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng
-- nhau
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b).