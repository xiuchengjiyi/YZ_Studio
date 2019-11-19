package com.yz.dao;

import java.util.List;

import com.yz.model.Record;
import com.yz.model.dto.GameDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年11月15日 下午4:39:30
 * 类说明
 */
public interface RecordMapper {
	
	//根据球队id查询球队战绩
	Record selectRecordByTeam_id(Record record);
	//新增球队战绩
	int insertRecord(Record record);
	//修改战绩
	int updateRecord(Record record);
	//查询NBA战绩榜
	List<Record> selectRecords(Record record);

}
