package kr.ac.hongik.vin.wine.service;

import java.util.List;

import kr.ac.hongik.vin.wine.dto.RecommendedWine;
import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineSearchList;


public interface WineService {
	public static final Integer LIMIT = 15;
	public List<WineSearchList> getWineSearchList(Integer start);
	public List<WineSearchList> getWineSearchListByCondition(Integer start, 
			String keyword,
			List<String> types,
			List<String> countries,
			List<Integer> alcohol,
			List<Integer> sweetness,
			List<Integer> acidity,
			List<Integer> body,
			List<Integer> tanin,
			List<Integer> price);
	public List<RecommendedWine> getRecommendedWinesList(Integer start);
	public int getCount();
	public Wine getWine(Integer wine21Code);
	
}
