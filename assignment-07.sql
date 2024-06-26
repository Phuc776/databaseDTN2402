-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước
DROP TRIGGER IF EXISTS trigger_01;
DELIMITER $$
CREATE TRIGGER trigger_01
BEFORE INSERT ON group_account
FOR EACH ROW
BEGIN
	DECLARE v_group_id INT;
    SELECT group_id into v_group_id
    FROM `group`
    WHERE created_date <= CURRENT_DATE() - INTERVAL 1 YEAR;
    
    IF NEW.group_id = v_group_id THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Không cho phép thêm vào group có ngày tạo trước 1 năm trước";
    END IF;
END $$
DELIMITER ;
-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
DROP TRIGGER IF EXISTS trigger_02;
DELIMITER $$
CREATE TRIGGER trigger_02
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
	DECLARE v_department_id INT;
    SELECT department_id into v_department_id
    FROM department
    WHERE department_name = "Sale";
    
    IF NEW.department_id = v_department_id THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Department Sale cannot add more user";
    END IF;
END $$
DELIMITER ;
-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS trigger_03;
DELIMITER $$
CREATE TRIGGER trigger_03
BEFORE INSERT ON group_account
FOR EACH ROW
BEGIN
	DECLARE v_account_count INT;
    
    SELECT COUNT(account_id) INTO v_account_count
    FROM group_account
    WHERE group_id = NEW.group_id;
    
    IF v_account_count >= 5 THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Mỗi group có tối đa 5 người.";
    END IF;
END $$
DELIMITER ;
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DELIMITER $$
CREATE TRIGGER trigger_04
BEFORE INSERT ON exam_question
FOR EACH ROW
BEGIN
	DECLARE v_question_count INT;
    
    SELECT COUNT(question_id) INTO v_question_count
    FROM exam_question
    WHERE exam_id = NEW.exam_id;
    
    IF v_question_count >= 10 THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Mỗi đề thi có tối đa 10 câu hỏi";
    END IF;
END $$
DELIMITER ;
-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DELIMITER $$
CREATE TRIGGER trigger_05
BEFORE DELETE ON account
FOR EACH ROW
BEGIN
	IF OLD.email = "admin@gmail.com"
    THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Đây là tài khoản admin, không cho phép user xóa";
    END IF;
END $$
DELIMITER ;
-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DELIMITER $$
CREATE TRIGGER trigger_06
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
	DECLARE v_department_id INT;

	IF NEW.department_ID IS NULL
    THEN
		SELECT department_id INTO v_department_id
        FROM department
        WHERE department_name = "Phòng chờ";
        
        SET NEW.department_ID = v_department_id;
    END IF;
END $$
DELIMITER ;
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DELIMITER $$
CREATE TRIGGER trigger_07
BEFORE INSERT ON exam
FOR EACH ROW
BEGIN
	DECLARE v_answer_count INT;
    DECLARE v_correct_answer_count INT;

	SELECT COUNT(answer_id) INTO v_answer_count
    FROM answer
    WHERE question_id = NEW.question_id;
    
    IF v_answer_count >= 4 THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Mỗi câu hỏi có tối đa 4 câu trả lời";
    END IF;
    
    SELECT COUNT(answer_id) INTO v_correct_answer_count
    FROM answer
    WHERE question_id = NEW.question_id AND is_correct = TRUE;
    
    IF v_correct_answer_count >= 2 THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Mỗi câu hỏi có tối đa 2 câu trả lời đúng";
    END IF;
END $$
DELIMITER ;
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DELIMITER $$
CREATE TRIGGER trigger_09
BEFORE DELETE ON exam
FOR EACH ROW
BEGIN
	IF OLD.created_date > CURRENT_DATE - INTERVAL 2 DAY THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Không thể xóa đề thi mới tạo được 2 ngày";
    END IF;
END $$
DELIMITER ;
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS trigger_10_update;
DELIMITER $$
CREATE TRIGGER trigger_10_update
BEFORE UPDATE ON question
FOR EACH ROW
BEGIN
	DECLARE v_exam_count INT;
    
    SELECT COUNT(exam_id) INTO v_exam_count
    FROM exam_question
    WHERE question_id = OLD.question_id;
    
    IF v_exam_count != 0 THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Có đề thi nào đó đang sử dụng câu hỏi này";
    END IF;
END $$
DELIMITER ;
DROP TRIGGER IF EXISTS trigger_10_delete;
DELIMITER $$
CREATE TRIGGER trigger_10_delete
BEFORE DELETE ON question
FOR EACH ROW
BEGIN
	DECLARE v_exam_count INT;
    
    SELECT COUNT(exam_id) INTO v_exam_count
    FROM exam_question
    WHERE question_id = OLD.question_id;
    
    IF v_exam_count != 0 THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Có đề thi nào đó đang sử dụng câu hỏi này";
    END IF;
END $$
DELIMITER ;
-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT *, 
	CASE
		WHEN Duration <= 30 THEN "Short time"
        WHEN Duration <= 60 THEN "Medium time"
        ELSE "Long time"
	END AS New_Duration
FROM exam;
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
WITH c13 AS (
	SELECT `group`.*, COUNT(account_id) AS account_count
	FROM `group`
	LEFT JOIN group_account USING (group_id)
	GROUP BY group_id
)
SELECT *,
	CASE
		WHEN account_count <= 5 THEN "few"
		WHEN account_count <= 20 THEN "normal"
		ELSE "higher"
	END AS the_number_user_amount
FROM c13;
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
WITH c14 AS (
	SELECT department.*, COUNT(account_id) AS account_count
    FROM department
    LEFT JOIN account USING (department_id)
    GROUP BY department_id
)
SELECT department_id, department_name,
	CASE
		WHEN account_count = 0 THEN "Không có user"
        ELSE account_count
    END AS account_number
FROM c14;