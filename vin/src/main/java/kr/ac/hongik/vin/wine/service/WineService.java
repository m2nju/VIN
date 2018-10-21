package kr.ac.hongik.vin.wine.service;

import java.util.List;

import kr.ac.hongik.vin.wine.dto.Wine;
import kr.ac.hongik.vin.wine.dto.WineSearchList;


public interface WineService {
	public static final Integer LIMIT = 15;
	public List<WineSearchList> getWineSearchList(Integer start);
	public int getCount();
	public Wine getWine(Integer wine21Code);
}
