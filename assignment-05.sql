-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
SELECT * FROM account
WHERE department_id = (
	SELECT department_id FROM department
    WHERE department_name = "Sale");
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều
-- group nhất
-- C1: subquery
SELECT account.*
FROM account
LEFT JOIN group_account USING (account_id)
GROUP BY account_id
HAVING COUNT(group_id) =
	(SELECT MAX(group_count)
	FROM 
		(SELECT COUNT(group_id) AS group_count
		FROM account
		LEFT JOIN group_account USING (account_id)
		GROUP BY account_id) AS t);
-- C2: 
WITH c2 as (
	SELECT account.*, COUNT(group_id) AS group_count
		FROM account
		LEFT JOIN group_account USING (account_id)
		GROUP BY account_id
)
SELECT * 
FROM c2
WHERE group_count = (
	SELECT MAX(group_count)
	FROM c2
);
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá
-- 300 từ được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW view_03 AS
SELECT * 
FROM question
WHERE CHAR_LENGTH(content) > 300;

DELETE FROM view_03;
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên
-- nhất
-- c1: subquery
CREATE OR REPLACE VIEW view_04 AS
SELECT department.*
FROM department
LEFT JOIN account USING (department_id)
GROUP BY department_id
HAVING COUNT(account_id) =
	(SELECT MAX(account_count)
	FROM
		(SELECT COUNT(account_id) AS account_count
		FROM department
		LEFT JOIN account USING (department_id)
		GROUP BY department_id) AS t);
-- c2: cte
CREATE OR REPLACE VIEW view_042 AS
WITH c4 AS (
	SELECT department.*, COUNT(account_id) AS account_count
		FROM department
		LEFT JOIN account USING (department_id)
		GROUP BY department_id
)
SELECT * 
FROM c4
WHERE account_count = (
	SELECT MAX(account_count)
    FROM c4
);
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo.
SELECT * FROM question
WHERE creator_id IN (
	SELECT account_id 
	FROM account
	WHERE full_name LIKE "Nguyễn %");