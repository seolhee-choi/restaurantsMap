<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<style>
    .btn_list ico_add func_list {

    }
</style>
<!-- content_head -->
<div class="content_header">
    <h3>맛집 리뷰</h3>
</div>

<div class="scroll" >
<div class="scroll_inner">
    <div class="srch_wrap">
        <div id="searchForm" class="srch_form"> 
            <table class="srch_table" id="reviewSearchForm">
                <input type="hidden" id="targetId" value="${param.restaurantId}">
                <input type="hidden" id="status" value="admin">
                <colgroup>
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                    <col style="width:70px">
                </colgroup>
                <tr>
                    <th>리뷰내용</th>
                    <td>
                        <div class="from_wrap_input">
                            <input type="text" id="description" name="description"  maxlength="20" data-checkRequired >
                        </div>
                    </td>
                    <th>키워드</th>
                    <td>
                        <div class="from_wrap_input">
                            <input type="text" id="keyword" name="keyword"  maxlength="20" data-checkRequired >
                        </div>
                    </td>
                    <th>댓글 사용여부</th>
                    <td>
                        <div class="from_wrap_input">
                            <ctag:combo id="useYn" codeGrp="G01" userSession="${pageContext.session}" spaceName=""/>
                        </div>
                    </td>
                    <td>
                        <div class="button fR">
                            <button id="btnSrch" class="btn_list ico_search" type="button" onclick="getReviewList()">Search</button>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style=" width: 100%; padding-top: 20px;">
        <div class="button fR">
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

    <c:if test="${!empty param.restaurantId}">
    getReviewList();
    </c:if>
        columns = [
            {field: 'restaurantName', caption: '식당이름', size: '10%',style : 'text-align:center'},
            {field: 'reviewId', caption: '리뷰아이디', size: '12%', style : 'text-align:left',
                 render: function(item){
                     return GridUtils.makeInputRender({id:"reviewId", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
	        },
            { field: 'description',	caption: '리뷰내용', size: '25%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"description", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
            },
            { field: 'rating',	caption: '별점', size: '5%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"rating", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
            },
            { field: 'comCode',	caption: '키워드', size: '10%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"comCodeNm", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
            },
           { field: 'createDate',	caption: '작성일자', size: '10%', style : 'text-align:center',
                render: function(item){
                    return GridUtils.makeInputRender({id:"createDate", treeId:"grid", rowData:item, option:"style='width:95%' data-checkRequired readonly"});
                 }
            },

            { field: 'useYn', caption: '댓글사용여부', size: '10%', style: 'text-align: center',
                render: function(item) {
                    return GridUtils.makeComboRender({id:"useYn", treeId:"grid", codeList:GV_CODES["G01"], spaceName:"", rowData:item, option:"style='width:95%'"});
                 }      
            },
        ];
        GridUtils.drawGrid({id:'grid', columns:columns});
        ComUtils.searchEvent($('#reviewSearchForm'), getReviewList);
        getReviewList();
    });

    function getReviewList() {
        	var data = ComUtils.getParams("reviewSearchForm");
            console.log("변화된 data",data);
            ComUtils.callAjax("${ctx}/web/userReview/getReviewList.do", data, function( resp ){
            if(resp.result == "T") {
                console.log(resp.data);
            	GridUtils.setRecords("grid", resp.data);
            } else {
                ComUtils.alert(resp);
            }
        });
    }

    //댓글사용여부 변경 후 저장
    $('#btnSave').on('click', function(){
       // if (ComUtils.validationCheck("grid")) {
        ComUtils.confirm("리뷰를 정말 비활성화 처리 하시겠습니까?", function(){
            var list = GridUtils.getAllData("grid");

            ComUtils.callAjax("${ctx}/admin/contents/saveRestrList.do", {data:list}, function(resp) {
                if(resp.result == "T") {
                    ComUtils.alert("리뷰가 비활성화 처리되었습니다.");
                    getReviewList();
                } else {
                    ComUtils.alert(resp);
                }
            });
        });
        ComUtils.alert('Enter empty item.');
    });

    //식당목록으로 돌아가기
    $('#btnList').on('click', function() {
        window.location.href = '${ctx}/admin/contents/localEat.view';
    });
</script>
	
	
	
				
					