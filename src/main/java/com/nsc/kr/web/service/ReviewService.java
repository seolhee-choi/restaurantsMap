package com.nsc.kr.web.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.nsc.common.model.ComParamVO;
import com.nsc.common.model.FileVO;
import com.nsc.common.service.AbstractService;
import com.nsc.common.utils.ComUtils;
import com.nsc.common.utils.FileUtils;
import com.nsc.common.utils.Info;
import com.nsc.kr.admin.service.CommonService;
import com.nsc.kr.web.dao.RestaurantDAO;
import com.nsc.kr.web.dao.ReviewDAO;
import io.swagger.models.auth.In;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @details 사용자측 맛집 리뷰 등록 시스템 Service
 * @author 최설희
 * @date 2024-03-19
 * @version 1.0.0
 */
@Service("userReviewService")
public class ReviewService extends AbstractService {
    protected final Logger logger = LoggerFactory.getLogger(RestaurantService.class);

    @Autowired
    private RestaurantDAO restaurantDAO;

    @Autowired
    private ReviewDAO reviewDAO;

    @Autowired
    private CommonService commonService;

    /* 리뷰 검색 */
    public List<Map<String, Object>> getReviewList(Map<String, Object> param) throws Exception {
        //TODO : resultMap으로 묶기(쿼리)
        return reviewDAO.getReviewList(param);
    }

    /* 리뷰 이미지 검색 */
    public List<Map<String, Object>> getReviewImage(Map<String, Object> param) throws Exception {
        return reviewDAO.getReviewImage(param);
    }

    /* 리뷰 아이디 일치여부 검색 */
//    public Object getUserIdByReviewId (Map<String, Object> param) throws Exception{
//        return reviewDAO.getUserIdByReviewId(param);
//    }
    public Object getUserIdByReviewId (String param) throws Exception{
        return reviewDAO.getUserIdByReviewId(param);
    }

    /* 식당 및 리뷰 등록(이미지 포함) */
    public void saveReview(Map<String, Object> param) throws Exception {
        Map<String, Object> map = new HashMap<>();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> restr = objectMapper.readValue((String) param.get("restr"), new TypeReference<Map<String, Object>>() {
        });
        String attachId = "";
        String userId = ((ComParamVO) param.get("__param")).getUserId();

        if (ComUtils.isEmpty(param.get("reviewId"))) {
            param.put("reviewId", commonService.getNextSeq("RT"));
        }
        restr.put("userId", userId);
        //식당등록이 처음일 때
        if(param.get("reviewStatus").equals("new")) {
            restaurantDAO.saveRestaurant(restr);
        }

        Path path = Paths.get(Info.getProperty("attach.file.path"));
        if (Files.exists(path) == false) {
            Files.createDirectories(path);
        }

        List<FileVO> files = (List<FileVO>) param.get("__attachList");

        for (FileVO vo : files) {
            attachId = commonService.getNextSeq("ME");
            String saveFileName = ComUtils.getUUID() + "." + vo.getFileExt();
            String saveFilePath = Paths.get(path.toString(), saveFileName).toString();
            try {
                FileUtils.writeStream(new File(saveFilePath), vo.getFileStream());
            } catch (Exception e) {
                e.printStackTrace();
            }

            map.put("userId", userId);
            map.put("attachId", attachId);
            map.put("reviewId", param.get("reviewId"));
            map.put("refSortNo", 1);
            map.put("fileNm", vo.getFileName());
            map.put("saveFileNm", saveFileName);
            map.put("saveFilePath", saveFilePath);
            map.put("ext", vo.getFileExt()); // 확장자
            map.put("size", Long.valueOf(vo.getFileSize()).intValue()); // 파일 크기
            reviewDAO.saveReviewImage(map);

        }
        reviewDAO.saveReview(param);

    }

    /* 리뷰 이미지 삭제 */
    public void deleteAttachImage(Map<String, Object> param) throws Exception {
        reviewDAO.deleteAttachImage(param);
    }

    /* 리뷰 삭제 */
    public void deleteReview(Map<String, Object> param) throws Exception {
        if (!ComUtils.isEmpty(param.get("restaurantId"))) {
            restaurantDAO.deleteRestaurant(param);
            reviewDAO.deleteReview(param);
        } else {
            reviewDAO.deleteReview(param);
        }
    }
}