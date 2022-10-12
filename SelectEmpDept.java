package a_statement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class SelectEmpDept {

	public static void main(String[] args) {
	
		try {
			//1.드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버로딩 성공2");
			
			//2.연결객체 얻어오기
			String url ="jdbc:oracle:thin:@192.168.0.26:1521:xe";
			String user ="scott";
			String pass ="tiger";

			Connection con = DriverManager.getConnection(url, user, pass);
			System.out.println("디비 연결 성공2");
			
			//3.SQL 문장 만들기(*****)
			// 	-> 20번 부서의 사원들의 정보 - 사번, 사원명, 월급, 부서명, 근무지
			String sql =" SELECT e.empno empno, e.ename ename, e.sal sal,"
					+ " d.dname dname, d.loc loc FROM emp e, dept d WHERE e.deptno =d.deptno and e.deptno =20";
			
			//4. 전송객체 얻어오기
			Statement stmt = con.createStatement();
			
			//5. 전송
			/*	- ResultSet executeQuery() : SELECT
			 * 	- int 		executeUpdate() : INSERT/DELETE/UPDATE
			 */
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int empno = rs.getInt("EMPNO");
				String ename = rs.getString("ENAME");
				int sal 	= rs.getInt("SAL");
				String dname = rs.getString("DNAME");
				String loc = rs.getString("LOC");
				System.out.println(empno +"/" + ename +"/"+ sal + "/" + dname+ "/" + loc);
			}
			
			//6. 닫기
			rs.close();
			stmt.close();
			con.close();
			
		} catch (Exception e) {
			System.out.println("실패: " + e);
		}
		

	}

}
