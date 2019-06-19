package kr.or.ddit.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;

import oracle.jdbc.pool.OracleDataSource;

public class ConnectionFactory {
	private static String url;
	private static String user;
	private static String password;
	private static DataSource dataSource;
	static {
		ResourceBundle rb = ResourceBundle.getBundle("kr.or.ddit.db.dbInfo");
		String driverClassName = rb.getString("driverClassName");
//		try {
//			Class.forName(driverClassName);
			url = rb.getString("url");
			user = rb.getString("user");
			password = rb.getString("password");
//			OracleDataSource realDS = new OracleDataSource();
//			realDS.setURL(url);
//			realDS.setUser(user);
//			realDS.setPassword(password);
//			dataSource = realDS;
			
			BasicDataSource realDS = new BasicDataSource();
			realDS.setDriverClassName(driverClassName);
			realDS.setUrl(url);
			realDS.setUsername(user);
			realDS.setPassword(password);
			realDS.setInitialSize(5);
			realDS.setMaxWaitMillis(2000);
			realDS.setMaxTotal(5);
			dataSource = realDS;
//		} catch (SQLException e) {
//			throw new RuntimeException(e);
//		}
	}
	public static Connection getConnection() throws SQLException {
//		Connection conn = DriverManager.getConnection(url, user, password);
		Connection conn = dataSource.getConnection();
		return conn;
	}
}







