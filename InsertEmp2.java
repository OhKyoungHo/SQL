package a_statement;

import java.sql.*;

public class InsertEmp2 {

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
			
			//-----입력값
			String bonmyeong ="오경호";
			int welgup = 10000;
			String jikup = "IT";
			
			//3. SQL 문장
			String sql = "INSERT INTO emp(empno,ename, sal,job)  " 
				+ " VALUES(seq_temp.nextval,'" + bonmyeong+"',"+welgup+",'"+jikup+"')";	
			System.out.println(sql);
			
			
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
