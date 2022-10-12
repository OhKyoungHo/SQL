package a_statement;

import java.sql.*;

public class InsertEmp {

	public static void main(String[] args) {

		try {
			//1.드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버로딩 성공");

			//2.연결객체 얻어오기
			String url ="jdbc:oracle:thin:@192.168.0.26:1521:xe";
			String user ="scott";
			String pass ="tiger";

			Connection con = DriverManager.getConnection(url, user, pass);
			System.out.println("디비 연결 성공");
			
			//3. SQL 문장
			String sql = "INSERT INTO emp(empno,ename, sal)  " 
				+ " VALUES(1112,'오경호',10000)";	//1100~1150
			//10번 부서의 사원의 월급을 10% 인상
			//String sql = "UPDATE emp SET sal = sal*1.1 WHERE deptno=10";
			//월급이 10000이상인 사원들 삭제
			//String sql="DELETE FROM emp_cp WHERE sal>=10000";
			
			
			
			//4. SQL 전송객체
			Statement stmt = con.createStatement();
			
			//5. SQL 전송
			/*	- ResultSet executeQuery() : SELECT
			 * 	- int executeUpdate() : INSERT/DELETE/UPDATE
			 */
			int result = stmt.executeUpdate(sql);
			System.out.println(result + "행을 실행");
			
			//6. 닫기
			stmt.close();
			con.close();
			
		} catch (Exception e) {
			System.out.println("DB 실패 :" + e);;
		}

	}

}
