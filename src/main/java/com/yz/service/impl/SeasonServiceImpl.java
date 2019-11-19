package com.yz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yz.dao.SeasonMapper;
import com.yz.model.Season;
import com.yz.service.SeasonService;

/**
 * @author ZGD
 * @version 创建时间：2019年11月13日 上午11:49:23
 * 类说明
 */
@Service
public class SeasonServiceImpl implements SeasonService {
	@Autowired
	private SeasonMapper seasonMapper;

	public List<Season> getSeasons() {
		List<Season> seasons = seasonMapper.getSeasons();
		return seasons;
	}

}
