package com.yz.service;

import java.util.List;

import com.yz.model.Record;
import com.yz.model.dto.GameDTO;

/**
 * @author ZGD
 * @version 创建时间：2019年11月15日 下午4:38:39
 * 类说明
 */
public interface RecordService {
	//根据球队id修改战绩
	int insertOrUpdateRecord(GameDTO gameDTO);
	//查询NBA战绩榜
	List<Record> getRecords(Record record);

}
