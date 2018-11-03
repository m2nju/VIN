package kr.ac.hongik.vin.wine.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.hongik.vin.wine.dao.WineDao;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineSearchList;
import kr.ac.hongik.vin.wine.service.WineService;

@Service	// 해당 class가 Service임을 명시하는 annotation
public class WineServiceImpl implements WineService {
	@Autowired
	WineDao wineDao;
	
	
	public List<WineSearchList> getWineSearchList(Integer start) {
		List<WineSearchList> list = wineDao.selectWinesSearchList(start, WineService.LIMIT);
		return list;
	}
	
	@Override
	@Transactional
	public List<WineSearchList> getWineSearchListByCondition(Integer start, 
			List<String> types,
			List<String> countries,
			List<Integer> alcohol,
			List<Integer> sweetness,
			List<Integer> acidity,
			List<Integer> body,
			List<Integer> tanin,
			List<Integer> price){
		System.out.println("service");
		List<WineSearchList> list = wineDao.selectWinesSearchListByConditions(start, WineService.LIMIT, types, countries, alcohol, sweetness, acidity, body, tanin, price);
		return list;
	}
	
	@Override
	public int getCount() {
		return wineDao.selectCount();
	}
	
	@Override
	public Wine getWine(Integer wine21Code) {
		return wineDao.selectWine(wine21Code);
	}
}
