package com.yz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yz.dao.RecordMapper;
import com.yz.model.Record;
import com.yz.model.dto.GameDTO;
import com.yz.service.RecordService;
import com.yz.utils.Utils;

/**
 * @author ZGD
 * @version 创建时间：2019年11月15日 下午4:39:09
 * 类说明
 */
@Service
public class RecordServiceImpl implements RecordService {
	
	@Autowired
	private RecordMapper recordMapper;
	
	
	//查询NBA战绩榜
	public List<Record> getRecords(Record record) {
		List<Record> records = recordMapper.selectRecords(record);
		return records;
	}

	//根据球队id修改战绩
	public int insertOrUpdateRecord(GameDTO gameDTO) {
		
		int code = 0;
		//先查询客队是否为第一次添加战绩
		Record record = new Record();
		record.setTeam_id(gameDTO.getAway_team());
		record.setSeason(gameDTO.getSeason());
		Record record2 = selectRecordByTeam_id(record);
		if (record2 == null) {
			//该球队该赛季第一次添加战绩
			if (gameDTO.getWin_team().equals(gameDTO.getAway_team())) {
				//客队赢球
				record.setWin(1);
				record.setLost(0);
				record.setWin_rate("100%");
			}else {
				//主队赢球
				record.setWin(0);
				record.setLost(1);
				record.setWin_rate("0%");
			}
			code = insertRecord(record);
		}else {
			//修改战绩
			if (gameDTO.getWin_team().equals(gameDTO.getAway_team())) {
				//客队赢球
				Integer win = record2.getWin() + 1;
				Integer lost = record2.getLost();
				String win_rate = Utils.getWin_rate(win,win+lost);
				record.setWin(win);
				record.setLost(lost);
				record.setWin_rate(win_rate);
			}else {
				//主队赢球
				Integer win = record2.getWin();
				Integer lost = record2.getLost() + 1;
				String win_rate = Utils.getWin_rate(win,win+lost);
				record.setWin(win);
				record.setLost(lost);
				record.setWin_rate(win_rate);
			}
			code = updateRecord(record);
		}
		
		//为主队修改战绩
		record.setTeam_id(gameDTO.getHome_team());
		record2 = selectRecordByTeam_id(record);
		if (record2 == null) {
			//该球队该赛季第一次添加战绩
			if (gameDTO.getWin_team().equals(gameDTO.getHome_team())) {
				//主队赢球
				record.setWin(1);
				record.setLost(0);
				record.setWin_rate("100%");
			}else {
				//客队赢球
				record.setWin(0);
				record.setLost(1);
				record.setWin_rate("0%");
			}
			code = insertRecord(record);
		}else {
			//修改战绩
			if (gameDTO.getWin_team().equals(gameDTO.getHome_team())) {
				//主队赢球
				Integer win = record2.getWin() + 1;
				Integer lost = record2.getLost();
				String win_rate = Utils.getWin_rate(win,win+lost);
				record.setWin(win);
				record.setLost(lost);
				record.setWin_rate(win_rate);
			}else {
				//客队赢球
				Integer win = record2.getWin();
				Integer lost = record2.getLost() + 1;
				String win_rate = Utils.getWin_rate(win,win+lost);
				record.setWin(win);
				record.setLost(lost);
				record.setWin_rate(win_rate);
			}
			code = updateRecord(record);
		}
		
		return code;
	}
	
	//修改战绩
	private int updateRecord(Record record) {
		int code = recordMapper.updateRecord(record);
		return code;
	}

	//插入战绩
	private int insertRecord(Record record) {
		int code = recordMapper.insertRecord(record);
		return code;
	}

	//根据球队id查询战绩
	public Record selectRecordByTeam_id(Record record){
		Record record2 = recordMapper.selectRecordByTeam_id(record);
		
		return record2;
	}

}
