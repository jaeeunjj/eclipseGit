package kr.or.ddit.dbprop.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.or.ddit.dbprop.dao.DataBasePropertyDAOImpl;
import kr.or.ddit.dbprop.dao.DataBasePropertyDAO_Mysql;
import kr.or.ddit.dbprop.dao.IDataBasePropertyDAO;
import kr.or.ddit.vo.DataBasePropertyVO;

public class DataBasePropertyService implements IDataBasePropertyService {
	// 결합력이 가장 높은 의존관계 형성법
	IDataBasePropertyDAO propDAO = new DataBasePropertyDAO_Mysql();
	
	/* (non-Javadoc)
	 * @see kr.or.ddit.dbprop.service.IDataBasePropertyService#readProperties()
	 */
	@Override
	public Map<String, Object> readProperties(){
		// raw data + 조회된 날짜
		Map<String, Object> rawModel = propDAO.selectDBProps();
		//가공(로직)
		List<DataBasePropertyVO> propList = (List) rawModel.get("propList");
		for(DataBasePropertyVO propVO : propList) {
			propVO.setProperty_value(propVO.getProperty_value()+new Date());
		}
		return rawModel;
	}
}
