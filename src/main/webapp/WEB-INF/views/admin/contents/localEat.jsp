<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- content_head -->
<div class="content_header">
    <h3>맛집</h3>
</div>

<div class="scroll" >
<div class="scroll_inner">
    <div class="srch_wrap">
        <div id="searchForm" class="srch_form"> 
            <table class="srch_table" id="restaurantSearchForm">
                <input type="hidden" id="status" value="admin">
                <colgroup>
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                </colgroup>
                <tr>
                    <th>식당이름</th>
                    <td>
                        <div class="from_wrap_input">
                           <input type="text" id="restrNm" name="restrNm"  maxlength="20" data-checkRequired >
                        </div>
                    </td>
                    <th>식당 카테고리</th>
                    <td>
                        <div class="from_wrap_input">
<%--                            <ctag:combo id="grpCd" codeGrp="R01" userSession="${pageContext.session}" spaceName=""/>--%>
                            <input type="text" id="srchCategory" name="srchCategory"  maxlength="50" data-checkRequired>
                        </div>
                    </td>
                    <th>식당 해시태그</th>
                    <td>
                        <div class="from_wrap_input">
                            <ctag:combo id="grpCd" codeGrp="R01" userSession="${pageContext.session}" spaceName=""/>
                        </div>
                    </td>
                    <th>즐겨찾기여부</th>
                    <td>
                        <div class="from_wrap_input">
                            <ctag:combo id="useYn" codeGrp="G01" userSession="${pageContext.session}" spaceName=""/>
                        </div>
                    </td>
                    <td>
                        <div class="button fR">
                            <button id="btnSrch" class="btn_list ico_search" type="button" onclick="getRestaurantList()">Search</button>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style=" width: 100%; padding-top: 20px;">
        <div class="button fR">
<%--            <button id="btnSave" class="btn_list ico_add func_save" type="button" style="display: inline-block;">Save</button>--%>
            <button id="btnSave" class="btn_list ico_add func_save" type="button" style="display: inline-block;">Save</button>
            <button id="btnList" class="btn_list ico_etc" type="button">List</button>
        </div>
    </div>
    <div style="width: 100%; height:100%; padding-top: 35px;">
        <div id="grid" style="height: 550px;"></div>
    </div>
</div>
</div>

<script type="text/javascript">
    GV_CODES["G07"] = ${ctag:comCode("G07", sessionScope.SESSION)};
    GV_CODES["G01"] = ${ctag:comCode("G01", sessionScope.SESSION)};
    $(function() {
        columns = [
			{field: 'restaurantName', caption: '식당이름',	size: '10%',style : 'text-align:center',
			    render: function(item){
			        return '<a href=\"#\" onclick=\"getReviewDetail(\''+item.restaurantId+'\',)">' + item.restaurantName;
			    }
            },
            {field: 'category', caption: '식당 카테고리',	size: '5%', style : 'text-align:left',
                 render: function(item){
                     return GridUtils.makeInputRender({id:"category", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
	        },
            { field: 'roadAddress',	caption: '도로명주소', size: '25%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"roadAddress", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
            },
            { field: 'tel',	caption: '전화', size: '8%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"tel", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
            },
            { field: 'count',	caption: '리뷰건수', size: '3%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"reviewCount", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                }
            },
            { field: 'favoriteStatus', caption: '즐겨찾기 여부', size: '5%', style: 'text-align: center',
                render: function(item) {
                    return GridUtils.makeComboRender({id:"favoriteStatus", treeId:"grid", codeList:GV_CODES["G01"], spaceName:"", rowData:item, option:"style='width:95%'"});
                 }      
            },

        ];
        GridUtils.drawGrid({id:'grid', columns:columns});
        getRestaurantList();

        ComUtils.searchEvent($('#restaurantSearchForm'), getRestaurantList);
    });

    //식당 리스트 조회
    function getRestaurantList() {
        	var data = ComUtils.getParams("restaurantSearchForm");
            ComUtils.callAjax("${ctx}/web/userRestaurant/getRestaurantList.do", data, function( resp ){
            if(resp.result == "T") {
            	GridUtils.setRecords("grid", resp.data);
            } else {
                ComUtils.alert(resp);
            }
        });
    }

    //식당이름 클릭시 해당식당의 리뷰관리페이지로 이동
    function getReviewDetail(id) {
        window.location.href = '${ctx}/admin/contents/localEatReview.view?restaurantId='+id;
    }

    //식당사용여부(favoriteStatus) 변경 후 저장
    $('#btnSave').on('click', function(){

        ComUtils.confirm("해당 식당의 즐겨찾기 상태를 변경하시겠어요?", function(){
            let list = GridUtils.getAllData('grid');
            list.forEach(item => {
                let restaurantId = item.restaurantId;
                let useYn = item.favoriteStatus;
                ComUtils.callAjax("${ctx}/web/userRestaurant/updateFavoriteStatus.do", {restaurantId:restaurantId, useYn:useYn}, function(resp) {
                    if(resp.result == "T") {
                        ComUtils.alert("식당의 즐겨찾기 상태가 변경되었습니다.");
                        getRestaurantList();
                    } else {
                        ComUtils.alert(resp);
                    }
                });
            });
        });
    });

    //식당목록으로 돌아가기
    $('#btnList').on('click', function() {
        window.location.href = '${ctx}/admin/contents/localEat.view';
    });
</script>
	
	
	
				
					