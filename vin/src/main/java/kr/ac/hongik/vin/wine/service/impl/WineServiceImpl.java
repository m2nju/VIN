package kr.ac.hongik.vin.wine.service.impl;

import static kr.ac.hongik.vin.wine.dao.WineDaoSqls.SELECT_PAGING;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.hongik.vin.wine.dao.WineDao;
import kr.ac.hongik.vin.wine.dto.WineSearchList;
import kr.ac.hongik.vin.wine.service.WineService;

@Service	// 해당 class가 Service임을 명시하는 annotation
public class WineServiceImpl implements WineService {
	@Autowired
	WineDao wineDao;
	
	@Override
	@Transactional
	public List<WineSearchList> getWineSearchList(Integer start) {
		List<WineSearchList> list = wineDao.selectWinesSearchList(start, WineService.LIMIT);
		return list;
	}
	
	@Override
	public int getCount() {
		return wineDao.selectCount();
	}
}
