package jdbc.functions;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DriverManagerDataSource;


public class SpringJdbcTest {
	static DriverManagerDataSource datasource = new DriverManagerDataSource();
	static JdbcTemplate template = null;

	static void establishConnection() {
		datasource.setDriverClassName("com.mysql.cj.jdbc.Driver");
		datasource.setUrl("jdbc:mysql://localhost:3306/my_db");
		datasource.setUsername("rashmi");
		datasource.setPassword("PASSw0rd");
		template = new JdbcTemplate(datasource);//write here,no need in all mtds
	}

	static void insertData(int deptno, String name, String loc) {

		//
		String query = "INSERT INTO DEPARTMENTS(deptno,name,location)values"
				+"(?,?,?)";
		int result = template.update(query,deptno,name,loc);
		if(result>0) {
			System.out.println(result+" row(s) has been inserted succesfully");
		}

	}

	static void updateDeptLoc(String newval, int deptno) {
		//template = new JdbcTemplate(datasource);
		String query = "UPDATE DEPARTMENTS SET location = ? where deptno = ?";
		int result = template.update(query,newval,deptno);
		if(result>0) {
			System.out.println(result+" row(s) has been updated succesfully");
		}

	}
	static void updateDeptName(String newval, int deptno) {
		//template = new JdbcTemplate(datasource);
		String query = "UPDATE DEPARTMENTS SET name = ? where deptno = ?";
		int result = template.update(query,newval,deptno);
		if(result>0) {
			System.out.println(result+" row(s) has been updated succesfully");
		}

	}
	static void updateDeptNo(int deptno,String newval) {
		//template = new JdbcTemplate(datasource);
		String query = "UPDATE DEPARTMENTS SET deptno = ? where name = ?";
		int result = template.update(query,deptno,newval);
		if(result>0) {
			System.out.println(result+" row(s) has been updated succesfully");
		}

	}

	static void deleteRecord(int deptno) {
		//template = new JdbcTemplate(datasource);
		String query = "DELETE FROM DEPARTMENTS WHERE deptno = ?";
		int result = template.update(query,deptno);
		if(result>0) {
			System.out.println(result+" row(s) has been deleted succesfully");
		}
	}
	static void fetchAllRecords() {
		String select_all = "Select * from Departments";
		RowMapper<Departments> rowmapper = new RowMapper<Departments>() {

			public Departments mapRow(ResultSet rs, int rowNum) throws SQLException {
				Integer deptno = rs.getInt("deptno");
				String name = rs.getString("name");
				String location = rs.getString("location");
				return new Departments(deptno,name,location);
			}

		};//anonymous class and rowmapper is an interface
		List<Departments>dpt = template.query(select_all, rowmapper);
		System.out.println("Dep No\t\tName\t\tLocation");
		for(Departments d:dpt) {
			System.out.println(d.deptno+"\t\t"+d.name+"\t\t"+d.location);
		}
	}

	public static void main(String[] args) {
		establishConnection();
		Scanner scan = new Scanner(System.in);
		do {
			System.out.println("1.Insert into the departments table");
			System.out.println("2.Update dept location");
			System.out.println("3.Update dept name");
			System.out.println("4.Update dept number");
			System.out.println("5.Delete a record");
			System.out.println("6.Show All Records");
			System.out.println("7.Exit");
			System.out.println("Select from [1-7]");
			int choice = scan.nextInt();

			switch(choice) {

			case 1:
				System.out.println("enter the department no");
				int deptno = scan.nextInt();
				System.out.println("enter the department name");
				String name = scan.next();
				System.out.println("enter the department location");
				String location = scan.next();
				insertData(deptno,name,location);
				break;

			case 2:
				System.out.println("Enter the location to be updated");
				String newLoc = scan.next();
				System.out.println("enter deptno");
				int dno = scan.nextInt();
				updateDeptLoc(newLoc, dno);
				break;

			case 3:
				System.out.println("Enter the dept name to be updated");
				String newName = scan.next();
				System.out.println("enter deptno");
				int deno = scan.nextInt();
				updateDeptName(newName, deno);
				break;

			case 4:
				System.out.println("Enter the dept number to be updated");
				int ddno = scan.nextInt();
				System.out.println("Enter the dept name");
				String nam = scan.next();
				updateDeptNo(ddno,nam);
				break;

			case 5:
				System.out.println("Enter the deptno of department to be deleted");
				int depno = scan.nextInt();
				
					deleteRecord(depno);	
				
				break;

			case 6:
				fetchAllRecords();
				break;

			case 7:return;

			default: System.out.println("Invalid choice");

			}

		}while(true);

	}

}
