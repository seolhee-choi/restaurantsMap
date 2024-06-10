package com.nsc.kr.web.dao;

import com.nsc.common.dao.AbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @details 사용자측 맛집 등록 시스템 DAO
 * @author 최설희
 * @date 2024-03-19
 * @version 1.0.0
 */
@Repository("userRestaurantDAO")
public class RestaurantDAO extends AbstractDAO {


    /* 식당 검색 */
    public List<Map<String, Object>> getRestaurantList(Map<String, Object> param) throws Exception {
        return selectList("web.restaurant.getRestaurantList", param);
    }

    /* 해시태그로 식당 검색 */
    public List<Map<String, Object>> getRestaurantByHashtag(Map<String, Object> param) throws Exception {
        return selectList("web.restaurant.getRestaurantByHashtag", param);
    }

    /* 이름으로 식당 검색 */
    public List<Map<String, Object>> getRestaurantByName(Map<String, Object> param) throws Exception {
        return selectList("web.restaurant.getRestaurantByName", param);
    }

    /* 식당 검색 후 맛집 등록 */
    public void saveRestaurant (Map<String, Object> param) throws Exception {
        update("web.restaurant.saveRestaurant", param);
    };

    /* 즐겨찾기 상태 검색 */
    public Object getFavoriteStatus (Map<String, Object> param) throws Exception {
        return selectOne("web.restaurant.getFavoriteStatus", param);
    }

    /* 즐겨찾기 상태 변경 */
    public void deleteRestaurant(Map<String, Object> param) throws Exception {
        update("web.restaurant.deleteRestaurant", param);
    }

    /* 관리자페이지에서 즐겨찾기 상태 변경 */
    public void updateFavoriteStatus(Map<String, Object> param) throws Exception {
        update("web.restaurant.updateFavoriteStatus", param);
    }
}
