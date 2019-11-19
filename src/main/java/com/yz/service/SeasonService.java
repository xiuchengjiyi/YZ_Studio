package com.yz.service;

import java.util.List;

import com.yz.model.Season;

/**
 * @author ZGD
 * @version 创建时间：2019年11月13日 上午11:48:16
 * 类说明
 */
public interface SeasonService {
	//查询所有赛季
	List<Season> getSeasons();

}
