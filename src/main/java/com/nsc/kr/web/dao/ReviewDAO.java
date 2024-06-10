package com.nsc.kr.web.dao;

import com.nsc.common.dao.AbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @details 사용자측 맛집 리뷰 등록 시스템 DAO
 * @author 최설희
 * @date 2024-03-19
 * @version 1.0.0
 */
@Repository("userReviewDAO")
public class ReviewDAO extends AbstractDAO {

    /* 리뷰 검색 */
    public List<Map<String, Object>> getReviewList(Map<String, Object> param) throws Exception {
        return selectList("web.review.getReviewList", param);
    }

    /* 리뷰 이미지 검색 */
    public List<Map<String, Object>> getReviewImage(Map<String, Object> param) throws Exception {
        return selectList("web.review.getReviewImage", param);
    }

    /* 리뷰 등록 */
    public void saveReview (Map<String, Object> param) throws Exception {
        update("web.review.saveReview", param);
    };

    /* 리뷰 이미지 등록 */
    public void saveReviewImage(Map<String, Object> param) throws Exception {
        update("web.review.saveReviewImage", param);
    }

    /* 리뷰 이미지 등록 */
    public void deleteAttachImage(Map<String, Object> param) throws Exception {
        delete("web.review.deleteAttachImage", param);
    }

    /* 리뷰 삭제 */
    public void deleteReview(Map<String, Object> param) throws Exception {
        update("web.review.deleteReview", param);
    }

    /* 리뷰 아이디 일치여부 검색 */
    public Object getUserIdByReviewId (String param) throws Exception {
        return selectOne("web.review.getUserIdByReviewId", param);
    }
}
