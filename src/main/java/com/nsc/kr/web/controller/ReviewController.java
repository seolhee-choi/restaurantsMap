package com.nsc.kr.web.controller;

import com.nsc.common.controller.AbstractController;
import com.nsc.common.exception.CommonException;
import com.nsc.common.exception.ErrorCode;
import com.nsc.common.model.ResultVO;
import com.nsc.common.model.UserVO;
import com.nsc.common.utils.ComUtils;
import com.nsc.kr.web.service.RestaurantService;
import com.nsc.kr.web.service.ReviewService;
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
 * @details 사용자측 맛집 리뷰 등록 시스템 Controller
 * @author 최설희
 * @date 2024-03-19
 * @version 1.0.0
 */
@RestController
@RequestMapping(value="/web/userReview")
public class ReviewController extends AbstractController {
    protected final Logger logger = LoggerFactory.getLogger(RestaurantController.class);

    @Autowired
    private RestaurantService restaurantService;

    @Autowired
    private ReviewService reviewService;

    /* 리뷰 검색 */
    @PostMapping(value = "/getReviewList.do")
    public ResponseEntity<Object> getReviewList(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResultVO<Object> resultVo = new ResultVO<Object>();

        try {
            resultVo.setData(reviewService.getReviewList(param));
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 리뷰 이미지 검색 */
    @PostMapping(value = "/getReviewImage.do")
    public ResponseEntity<Object> getReviewImage(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResultVO<Object> resultVo = new ResultVO<Object>();

        try {
            resultVo.setData(reviewService.getReviewImage(param));
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 리뷰 등록 */
    @PostMapping(value = "/saveReview.do")
    public ResponseEntity<Object> saveReview(Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) {
        ResultVO<Object> resultVo = new ResultVO<Object>();
        try {
            if(param.get("reviewStatus").equals("edit")) {
                UserVO user = ComUtils.getSessionUserVO(request);
                String reviewId = (String) param.get("reviewId");
                String createUserID = ComUtils.removeDomain((String) reviewService.getUserIdByReviewId(reviewId));
                if (!createUserID.equals(ComUtils.removeDomain(user.getUserId()))) {
                    throw new CommonException(ErrorCode.ERR_1004);
                }
            }
            reviewService.saveReview(param);
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 리뷰 삭제 */
    @PostMapping(value="deleteReview.do")
    public ResponseEntity<Object> deleteReview(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) {
        ResultVO<Object> resultVo = new ResultVO<>();
        try {
            reviewService.deleteReview(param);
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }

    /* 리뷰 이미지 삭제 */
    @PostMapping(value="deleteAttachImage.do")
    public ResponseEntity<Object> deleteAttachImage(@RequestBody Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) {
        ResultVO<Object> resultVo = new ResultVO<>();
        try {
            reviewService.deleteAttachImage(param);
        } catch (Exception e) {
            resultVo.setError(e);
            logger.error(e.getMessage(), e);
        }
        return resultOut(resultVo);
    }


}
