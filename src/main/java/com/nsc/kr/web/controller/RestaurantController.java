package com.nsc.kr.web.controller;

import com.nsc.common.controller.AbstractController;
import com.nsc.common.model.ResultVO;
import com.nsc.kr.web.service.RestaurantService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @details 사용자측 맛집 등록 시스템 Controller
 * @author 최설희
 * @date 2024-03-19
 * @version 1.0.0
 */

@RestController
@RequestMapping(value="/web/userRestaurant")
public class RestaurantController extends AbstractController {
    protected final Logger logger = LoggerFactory.getLogger(RestaurantController.class);

    @Autowired
    private RestaurantService restaurantService;

    /* 식당 검색 */
    @PostMapping(value = "/getRestaurantList.do")
    public ResponseEntity<Object> getRestaurantList(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResultVO<Object> resultVo = new ResultVO<Object>();

        try {
            resultVo.setData(restaurantService.getRestaurantList(param));
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 해시태그로 식당 검색 */
    @PostMapping(value = "/getRestaurantByHashtag.do")
    public ResponseEntity<Object> getRestaurantByHashtag(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResultVO<Object> resultVo = new ResultVO<Object>();

        try {
            resultVo.setData(restaurantService.getRestaurantByHashtag(param));
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 이름으로 식당 검색 */
    @PostMapping(value = "/getRestaurantByName.do")
    public ResponseEntity<Object> getRestaurantByName(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResultVO<Object> resultVo = new ResultVO<Object>();

        try {
            resultVo.setData(restaurantService.getRestaurantByName(param));
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 식당 검색 후 맛집 등록 */
    @PostMapping(value = "/saveRestaurant.do")
    public ResponseEntity<Object> saveRestaurant(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception{
        ResultVO<Object> resultVo = new ResultVO<Object>();
        try {
            restaurantService.saveRestaurant(param);
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 즐겨찾기 상태 변경 */
    @PostMapping(value = "/getFavoriteStatus.do")
    public ResponseEntity<Object> getFavoriteStatus(@RequestBody Map<String, Object> param,HttpServletRequest request, HttpServletResponse response) throws Exception{
        ResultVO<Object> resultVo = new ResultVO<Object>();
        try {
            resultVo.setData(restaurantService.getFavoriteStatus(param));
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);

    }

    /* 관리자페이지에서 즐겨찾기 상태 변경 */
    @PostMapping(value = "/updateFavoriteStatus.do")
    public ResponseEntity<Object> updateFavoriteStatus(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception{
        ResultVO<Object> resultVo = new ResultVO<Object>();
        try {
            restaurantService.updateFavoriteStatus(param);
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }
}
