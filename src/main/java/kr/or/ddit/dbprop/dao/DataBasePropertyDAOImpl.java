package kr.or.ddit.dbprop.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.db.ConnectionFactory;
import kr.or.ddit.vo.DataBasePropertyVO;

public class DataBasePropertyDAOImpl implements IDataBasePropertyDAO{
	
	@Override
	public Map<String, Object> selectDBProps(){
		try(
				Connection conn = ConnectionFactory.getConnection();
				Statement stmt = conn.createStatement();
			){
				String sql = "SELECT PROPERTY_NAME, PROPERTY_VALUE, DESCRIPTION FROM DATABASE_PROPERTIES";
				ResultSet rs = stmt.executeQuery(sql);
				ResultSetMetaData rsmd = rs.getMetaData();
				int colCnt = rsmd.getColumnCount();
				String[] headers = new String[colCnt];
				for(int i=1; i<=colCnt; i++) {
					headers[i-1] = rsmd.getColumnLabel(i);
				}
				List<DataBasePropertyVO> propList = new ArrayList<DataBasePropertyVO>();
				while (rs.next()) {
					DataBasePropertyVO propVO =	DataBasePropertyVO.builder()
												.property_name(rs.getString("PROPERTY_NAME"))
												.property_value(rs.getString("PROPERTY_VALUE"))
												.description(rs.getString("DESCRIPTION"))
												.build();
					propList.add(propVO);
				}
				Map<String, Object> model = new HashMap<String, Object>();
				
				model.put("propList", propList);
				model.put("headers", headers);
				
				return model;
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}		
	}
}
