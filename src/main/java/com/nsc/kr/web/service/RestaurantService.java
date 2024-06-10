package com.nsc.kr.web.service;

import com.nsc.common.service.AbstractService;
import com.nsc.common.utils.ComUtils;
import com.nsc.kr.admin.service.CommonService;
import com.nsc.kr.web.dao.RestaurantDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @details 사용자측 맛집 등록 시스템 Service
 * @author 최설희
 * @date 2024-03-19
 * @version 1.0.0
 */
@Service("userRestaurantService")
public class RestaurantService extends AbstractService {
    protected final Logger logger = LoggerFactory.getLogger(RestaurantService.class);

    @Autowired
    private RestaurantDAO restaurantDAO;

    @Autowired
    private CommonService commonService;

    /* 식당 검색 */
    public List<Map<String, Object>> getRestaurantList(Map<String, Object> param) throws Exception {
        return restaurantDAO.getRestaurantList(param);
    }

    /* 해시태그로 식당 검색 */
    public List<Map<String, Object>> getRestaurantByHashtag(Map<String, Object> param) throws Exception {
        return restaurantDAO.getRestaurantByHashtag(param);
    }

    /* 이름으로 식당 검색 */
    public List<Map<String, Object>> getRestaurantByName(Map<String, Object> param) throws Exception {
        return restaurantDAO.getRestaurantByName(param);
    }

    /* 식당 검색 후 맛집 등록 */
    public void saveRestaurant(Map<String, Object> param) throws Exception {
        restaurantDAO.saveRestaurant(param);
        System.out.println("맛집이 잘 등록되었다~~~~");
    }

    /* 즐겨찾기 상태 변경 */
    public Object getFavoriteStatus (Map<String, Object> param) throws Exception{
        return restaurantDAO.getFavoriteStatus(param);
    }

    /* 관리자페이지에서 즐겨찾기 상태 변경 */
    public void updateFavoriteStatus(Map<String, Object> param) throws Exception {
        restaurantDAO.updateFavoriteStatus(param);
    }


}
