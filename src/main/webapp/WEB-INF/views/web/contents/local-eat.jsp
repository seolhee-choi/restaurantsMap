<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<c:choose>
<c:when test="${sessionScope.SESSION != null}">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Round&v=1711523209761" rel="stylesheet">
<link href="//fonts.googleapis.com/css2?family=Material+Icons+Sharp&amp;v=1711527806125" rel="stylesheet">
<link href="//fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&amp;v=1711523250332" rel="stylesheet">
<link href="//fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&amp;v=1711523272000" rel="stylesheet">
<link href="//fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&amp;v=1711523274405" rel="stylesheet">
<link href="//fonts.googleapis.com/css2?family=Material+Icons+Outlined&amp;v=1711527562073" rel="stylesheet">
<!-- 240408 추가-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<div class="contents">
    <section class="sub-top">
        <div class="inner">
            <h3>맛집 지도</h3>
            <p style="color:black;">맛집으로 등록할 식당명을 검색 후, 별표 모양을 누르면 맛집으로 등록이 가능해요</p>
            <p style="font-size:16px; color:black;">(이미 맛집으로 등록된 식당은 리뷰도 볼 수 있어요)</p>
        </div>
    </section>

    <!-- 맛집 카카오지도 S -->
    <div class="map_wrap">
        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

        <div class="menuSearch_wrap" id="menuSearch_wrap">
            <div class="menuSearch_box">

                <!-- 검색리스트 -->
                <div class="menuSearch_list">
                    <div class="fdplace-top">
                        <div class="search-container" >
                            <div class="search-radio">
                                <div class="north-form-radio">
                                    <input type="radio" id="normal" name="searchType"  data-toggle="target_text" checked>
                                    <label for="normal">일반검색</label>
                                </div>
                                <div class="north-form-radio">
                                    <input type="radio" id="hashtag" name="searchType"  data-toggle="target_select">
                                    <label for="hashtag">해시태그검색</label>
                                </div>
                            </div>
                            <div class="search-center" stlye="margin-left:auto;">
                                <button id="srchCenter" type="button" style="display: inline-block; font-size: 18px;">📍️</button>
                            </div>
                        </div>
                        <div class="search is-active" data-toggle-target="target_text">
                            <form id="searchForm">
                                <input type="text" id="keyword" class="quicksearch" value="" placeholder="식당명을 입력해 주세요"/>
                                <button type="submit"></button>
                            </form>
                        </div>
                        <div class="select-wrap type-food" data-toggle-target="target_select">
                            <select id="foodSelect">
                                <option value="">선택하세요</option>
                            </select>
                        </div>
                    </div>

                    <div class="fdplace-list" id="fdplace-list"></div>
                    <div id="pagination"></div>
                </div>

                <!-- 리뷰보기시 식당정보 -->
                <div class="menuSearch_desc" id="menuSearchDesc">
                    <input type="hidden" id="targetId">
                    <span class="btn-close pop-close"></span>

                    <div class="fdplace-wrap">
                        <!-- 식당정보 -->
                        <div class="place-info">
                            <p class="place-img" id="placeImage"></p>
                            <div class="detail">
                                <h6 id="placeName"></h6>
                                <div>
                                    <div class="rv-point">
                                        <div class="rating-wrap" id="placeRating"></div>
                                        <div class="rv-count" id="placeReviewCnt"></div>
                                    </div>
                                    <p class="loc" id="placeAddress" ></p>
                                    <p id="placePhone"></p>
                                </div>
                            </div>
                        </div><!-- //place-info -->
                        <!-- 리뷰리스트가 showReviewList()에서 그려짐 -->
                    </div>
                </div>
            </div>
        </div>
    </div><!-- 맛집 카카오지도 E -->
</div><!-- //contents -->


<!-- 맛집리뷰 popup-->
<div class="popup menuReview-pop">  <!-- .show 여부에 따라 팝업이 보여짐/ data-pop과 일치하는 class의 팝업을 띄움 -->
    <div class="pop-wrap">
        <span class="btn-close pop-close"></span>
        <div class="layer__section">
        <form id="reviewForm">
            <input type="hidden" id="restaurantId" value="">
            <input type="hidden" id="reviewId" value="">
            <input type="hidden" id="hashTags" value="">
            <input type="hidden" id="reviewStatus" value="">
            <div class="layer__header">
                <span>맛집 리뷰 작성</span>
            </div>
            <div class="layer_contet">
                <dl class="review-form-box">
                    <dd class="hashtag-title"></dd>
                    <dd class="hashTag"></dd>
                    <dd>
                        <ul class="ratingW" id="rating" data-checkRequired>
                            <li><a href="javascript:void(0);"><div class="star"></div></a></li>
                            <li><a href="javascript:void(0);"><div class="star"></div></a></li>
                            <li><a href="javascript:void(0);"><div class="star"></div></a></li>
                            <li><a href="javascript:void(0);"><div class="star"></div></a></li>
                            <li><a href="javascript:void(0);"><div class="star"></div></a></li>
                        </ul>
                    </dd>
                    <dd>
                        <div class="sus-form-textarea"><!-- error시 클래스 추가 -->
                            <textarea id="description" title="text" placeholder="리뷰 내용을 입력해 주세요*" data-checkRequired></textarea>
                        </div>
                    </dd>
                    <dd>
                        <div class="sus-fileupload" id="imgFile">
                            <span class="file-upload-info info-text">
                                ※ 첨부파일은 최대 3개까지 등록할 수 있습니다. (첨부파일 용량은 최대 9MB)
                            </span>
                        </div>
                        <div class="fh-file-list"></div>
                    </dd>
                </dl>
            </div>
            <div class="layer__footer alert_footer">
                <span class="scoreNow">0</span>
                <button type="button" class="layer_btn_multi btn_grey pop-close"><span>취소</span></button>
                <button type="button" class="layer_btn_multi" id="rvBtn" onclick="submitReview()"><span>리뷰등록</span></button>
            </div>
        </form>
        </div>
    </div>
</div>

<!-- 240408추가 Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<!-- 카카오지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c239e7d62c5b5fb90502c26ec1ff3b63&libraries=services"></script>
<script>
    GV_CODES['R01'] = ${ctag:comCode('R01', sessionScope.SESSION)};
    const clientX = '37.54019160000037';    // 회사 현재 위도
    const clientY = '127.05509650000135';   // 회사 현재 경도
    let restrData = new Map();              // 식당 정보를 담을 Map
    let deletedFiles = [];                  // 리뷰이미지 삭제한 파일 담는 배열
    var markers = [];                       // 마커를 담을 배열
    var map;                                // 지도 객체 생성
    var center;                             // 지도 중심 위치 기준
    var ps;                                 // 장소 검색 객체 생성
    var infowindow = new kakao.maps.InfoWindow({ zIndex: 1, removable: true });//0409
    var markerData;


    // 페이지 로드 시 실행되는 함수hk
    window.onload = function() {
        //     getLocation();
        showPosition();
    };

    // 사용자의 현재 위치를 가져오는 함수
    // function getLocation() {
    //     if (navigator.geolocation) {
    //         navigator.geolocation.getCurrentPosition(showPosition);
    //     } else {
    //         alert("Geolocation is not supported by this browser.");
    //     }
    // }

    //api 호출 후 결과가 정상이고 결과값이 있을 때 조건 함수화
    function isResultOk(resp) {
        return resp.result == "T" && !ComUtils.isEmpty(resp.data);
    }

    // 사용자의 위치를 받아와 지도를 초기화하는 함수
    function showPosition(position) {

        // 지도 초기화
        var container = document.getElementById('map');
        var options = {
            //현재 위치 사용 기능 http 프로토콜에서는 불가하여 회사기준으로 좌표 찍음
            center: new kakao.maps.LatLng(clientX, clientY),
            level: 5
        };
        map = new kakao.maps.Map(container, options);
        center = map.getCenter();
        ps = new kakao.maps.services.Places(); // 장소 검색 객체 초기화

        // 검색 시작
        document.getElementById("searchForm").addEventListener("submit", function(event) {
            event.preventDefault(); // 폼 제출 기본 동작 방지
            infowindow.close();
            searchPlaces();         // 검색 함수 호출
            $('#menuSearchDesc').css('display', 'none');
        });

        drawDBRestaurant();
    }

    // 클릭시 회사 위치로 이동
    $('#srchCenter').on('click', function(){
        var moveLatLon = new kakao.maps.LatLng(clientX, clientY);
        map.setCenter(moveLatLon); // 지도 중심을 이동
    });


    // 즐겨찾기된 마커를 생성하는 함수
    function createFavoriteMarkers() {
        markerData.forEach(function(data) {
            // 마커 생성 및 지도에 표시
            var markerPosition = new kakao.maps.LatLng(data.coordinateY, data.coordinateX);
            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
                imageSize = new kakao.maps.Size(24, 35),  // 마커 이미지의 크기
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
                marker = new kakao.maps.Marker({
                    position: markerPosition,
                    image: markerImage
                });

            marker.setMap(map);
            //클릭 이벤트 핸들러 추가
            kakao.maps.event.addListener(marker, 'click', function () {
                // ps.keywordSearch(data.restaurantName, placesSearchCB);
                ps.keywordSearch(data.restaurantName, placesSearchName(data.restaurantName));
                let content = `
                        <div class="restr-body">
                            <div class="restr-name">` + data.restaurantName + `
                                <span class="restr-category">` + data.category+ `</span>
                            </div>
                            <div class="restr-addr">` + data.roadAddress + `</div>
                            <div class="restr-jibun">` + data.jibunAddress + `</div>
                            <div class="restr-tel">` + data.tel + `</div>
                            <div class="restr-rating" style="color:black;">⭐`+ data.avgRating +`</div>
                        </div>
                    `;

                infowindow.setContent(content);
                infowindow.open(map,marker);
                $('#menuSearchDesc').css('display', 'none');
            });
        });
    }

    // 일반 & 해시태그 검색 radio 버튼 요소를 가져와 검색결과 리스트 초기화하는 함수
    const radioButtons = document.getElementsByName('searchType');
        radioButtons.forEach(radioButton => { // 라디오 버튼의 변경 이벤트를 감지하여 처리
            radioButton.addEventListener('change', function() {
                clearSearchResults();         // 라디오 버튼이 변경될 때마다 검색 결과 리스트를 초기화
            });
    });

    // 검색 결과 리스트를 초기화하는 함수
    function clearSearchResults() {
        const searchResults = document.getElementById('fdplace-list'); // 검색 결과를 표시하는 요소를 찾아 초기화
        searchResults.innerHTML = '';                                  // 검색 결과 초기화
    }

    // 키워드 검색을 요청하는 함수
    function searchPlaces() {
        var sw = new kakao.maps.LatLng(36, 127),
            ne = new kakao.maps.LatLng(37, 128),
            bo = new kakao.maps.LatLng(sw, ne);
        var keyword = document.getElementById('keyword').value;
        // let searchType = $("input[name='searchType']:checked").val(); //일반 or 해시태그

        if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
        }

        // if (searchType == "normal") { //일반 검색
            ps.keywordSearch(keyword, placesSearchCB, {
                location: center,
                sort: kakao.maps.services.SortBy.DISTANCE
                // bounds: bo
            });
        // }
    }

    // 해시태그 검색을 요청하는 함수
    function searchHashTag() {
        var selectElement = document.getElementById('foodSelect');
        var hashTagOptions = GV_CODES['R01'];

        hashTagOptions.forEach(hashTagOption => {
            var option = document.createElement('option');
            option.value = hashTagOption.cdNm;
            option.text = hashTagOption.cdNm;
            selectElement.appendChild(option);
        });

        $('#foodSelect').niceSelect();

        $('#foodSelect').on('change', function() {
            placesSearchHashTag(this.value); //선택된 해시태그 키워드로 검색
            console.log(this.value);
        });
    }

    $(document).ready(function() {
        searchHashTag();
    });

    // 해시태그 검색시 select-option
    $(document).on('click', '[data-toggle]', function () {
        const $target = $(this).attr('data-toggle');
        const $this = '[data-toggle-target="'+$target+'"]';

        $('[data-toggle-target]').removeClass('is-active');
        $($this).addClass('is-active');

        if($target === 'target_select'){
            $('.select-wrap.type-food select').val('');
            $('.select-wrap.type-food select').niceSelect('update');
        }
    });

    // 해시태그 검색이 완료됐을 때 호출되는 콜백함수
    function placesSearchHashTag(data) {
        ComUtils.callAjax("${ctx}/web/userRestaurant/getRestaurantByHashtag.do", {keyword:data}, function(resp) {
            if (isResultOk(resp)) {// 정상적으로 검색이 완료됐으면 검색 목록과 마커를 표출
                displayPlaces(resp.data);
                displayPagination(pagination);// 페이지 번호 표출
            } else {
                alert('검색 결과가 존재하지 않습니다.');
                console.log("getRestaurantList API 호출 실패");
            }
        });
    }

    // 식당명으로 검색이 완료됐을 때 호출되는 콜백함수
    function placesSearchName(data) {
        ComUtils.callAjax("${ctx}/web/userRestaurant/getRestaurantByName.do", {restaurantName:data}, function(resp) {
            if (isResultOk(resp)) {// 정상적으로 검색이 완료됐으면 검색 목록과 마커를 표출
                displayPlaces(resp.data);
                displayPagination(pagination);// 페이지 번호 표출
            } else {
                alert('검색 결과가 존재하지 않습니다.');
                console.log("getRestaurantByName API 호출 실패");
            }
        });
    }

    // 장소검색이 완료됐을 때 호출되는 콜백함수
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 검색 완료 시 Map 초기화
            restrData = new Map();
            let placeList = data.map(item => item.id);

            ComUtils.callAjax("${ctx}/web/userRestaurant/getRestaurantList.do", {placeList: placeList}, function(resp) {
                if (resp.result == "T") {
                    //검색결과와 DB의 id값을 비교해서 DB에 id값이 있으면 favoriteStatus를 검색결과에 주입
                    const updatedData = data.map(item => {
                        const foundItem = resp.data.find(dbItem => dbItem.restaurantId === item.id);
                        const updatedItem = foundItem ? {
                                                ...item, favoriteStatus: foundItem.favoriteStatus
                                                , totalRating: foundItem.totalRating
                                                , totalReview: foundItem.reviewCount
                                                , avgRating: foundItem.avgRating
                                            } : item;

                        //카카오 API의 category가 '음식점>카페' 인 경우, 카페만 추출
                        let splitCategory = updatedItem.category_name.split(">").map(item => item.trim());
                        updatedItem.category_name = splitCategory[1];

                        return updatedItem;
                    });
                    displayPlaces(updatedData); // 정상적으로 검색이 완료됐으면 검색 목록과 마커를 표출
                    displayPagination(pagination); // 페이지 번호 표출
                } else {
                    console.log("getRestaurantList API 호출 실패");
                }
            });
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            alert('검색 결과가 존재하지 않습니다.');
            return;
        } else if (status === kakao.maps.services.Status.ERROR) {
            alert('검색 결과 중 오류가 발생했습니다.');
            return;
        }
    }

    // 검색 결과 목록과 마커를 표출하는 함수
    function displayPlaces(places) {
        var listEl = document.getElementById('fdplace-list'),
            menuEl = document.getElementById('menuSearch_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds();

        removeAllChildNods(listEl);// 검색 결과 목록에 추가된 항목들을 제거
        removeMarker(); // 지도에 표시되고 있는 마커를 제거

        for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때 해당 장소에 인포윈도우에 장소명을 표시
            (function(marker, title) {
                // kakao.maps.event.addListener(marker, 'mouseover', function() {
                //     displayInfowindow(marker, title);
                // });

                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                });

                // itemEl.onmouseover =  function () {
                itemEl.onclick =  function () {
                    displayInfowindow(marker, title);
                };

                itemEl.onmouseout =  function () { // mouseout 했을 때는 인포윈도우를 닫음
                    infowindow.close();
                };
            })(marker, places[i].place_name);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Element에 추가
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수
    function getListItem(index, places) {
        restrData.set(places.id, places)//{"id" => object}
        const el = document.createElement('div');
        el.classList.add('item');

        // Detail div 생성
        const detailDiv = document.createElement('div');
        detailDiv.classList.add('detail');

        // 식당명
        const h6 = document.createElement('h6');
        h6.textContent = places.place_name;

        // 즐겨찾기 버튼
        const bookmarkButton = document.createElement('button');
        bookmarkButton.type = 'button';
        bookmarkButton.classList.add('btn-bookmark');
        bookmarkButton.id = places.id;
        bookmarkButton.addEventListener('click', () => {
            if(!ComUtils.isEmpty(places) && places.favoriteStatus) {
                alert("이미 맛집으로 등록된 식당이에요! \n등록해제는 관리자에게 문의주세요.");
            } else {
                let isConfirmed = confirm("맛집으로 등록하려면 리뷰를 등록해야합니다.\n첫 리뷰를 등록해볼까요?");
                if (isConfirmed) {
                    writeReview(places.id, 'new');
                } else {
                    // 사용자가 '취소'를 클릭한 경우 아무것도 하지 않음 (대화 상자가 자동으로 닫힘)
                }
            }
        });

        // 즐겨찾기 상태에 따라 아이콘 변경
        const starIcon = document.createElement('span');
        starIcon.classList.add('material-icons-outlined');
        starIcon.textContent = 'star';
        if (!ComUtils.isEmpty(places) && places.favoriteStatus) {
            starIcon.classList.add('active');
        }

        bookmarkButton.appendChild(starIcon);

        // 별점 및 리뷰개수 감싸는 DIV
        const rvDiv = document.createElement('div');
        rvDiv.classList.add('rv-point');

        //별점
        const ratingDiv = document.createElement('div');
        ratingDiv.classList.add('rating-wrap');
        const starSpan = document.createElement('span');
        starSpan.classList.add('material-icons-outlined');
        starSpan.textContent = 'star';
        const ratingEm = document.createElement('em');
        ratingEm.textContent = places.avgRating;

        ratingDiv.appendChild(starSpan);
        ratingDiv.appendChild(ratingEm);

        //리뷰개수
        const reviewDiv = document.createElement('div');
        reviewDiv.classList.add('rv-count');
        reviewDiv.textContent = '리뷰('+places.totalReview+')';

        rvDiv.appendChild(ratingDiv);
        rvDiv.appendChild(reviewDiv);
        h6.appendChild(bookmarkButton);

        //감싸는 Div생성
        const contactDiv = document.createElement('div');

        // 식당 주소
        const locP = document.createElement('p');
        locP.classList.add('loc');
        locP.style.fontSize = '13px';
        locP.style.marginTop = '8px';
        locP.style.marginBottom = '10px';
        locP.textContent = places.address_name;

        // 식당 연락처
        const contactP = document.createElement('p');
        contactP.classList.add('tel');
        contactP.style.fontSize = '13px';
        contactP.textContent = places.phone ? 'T. '+places.phone : '';

        //리뷰보기 및 리뷰등록
        const reviewViewLink = document.createElement('a');
        reviewViewLink.href = '#none';
        !ComUtils.isEmpty(places) && places.favoriteStatus && reviewViewLink.classList.add('btn-txt', 'review-view');
        reviewViewLink.id = places.id+'_button';
        reviewViewLink.textContent = !ComUtils.isEmpty(places) && places.favoriteStatus ? '리뷰보기' : '';
        reviewViewLink.addEventListener('click', () => showReviewList(places));

        const reviewWriteLink = document.createElement('a');
        reviewWriteLink.href = '#none';
        !ComUtils.isEmpty(places) && places.favoriteStatus && reviewWriteLink.classList.add('btn-txt', 'review-write');
        reviewWriteLink.setAttribute('data-pop', 'menuReview-pop');
        reviewWriteLink.textContent = !ComUtils.isEmpty(places) && places.favoriteStatus ? '리뷰작성' : '';
        reviewWriteLink.addEventListener('click', () => writeReview(places.id, 'new'));

        contactP.appendChild(reviewViewLink);
        contactP.appendChild(reviewWriteLink);

        // 구조 조립
        detailDiv.appendChild(h6);
        detailDiv.appendChild(!ComUtils.isEmpty(places) && places.favoriteStatus ? rvDiv : document.createTextNode(''));
        // detailDiv.appendChild(rvDiv);
        contactDiv.appendChild(locP);
        contactDiv.appendChild(contactP);

        el.appendChild(detailDiv);
        el.appendChild(contactDiv);

        // 상위 컨테이너에 el 추가
        // document.querySelector('.fdplace-list').appendChild(el);

        // 각 검색 결과 항목을 클릭했을 때 해당 마커 위치로 이동하는 이벤트 리스너를 추가
        el.querySelector('h6').addEventListener('click', function() {
            var position = new kakao.maps.LatLng(places.y, places.x);
            map.setLevel(3);
            map.panTo(position,{ animate: { cancelable: false } }); // 해당 마커로 이동합니다.
        });

        return el;
    }

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수
    function addMarker(position, idx, title) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions =  {
                spriteSize : new kakao.maps.Size(0, 0),     // 스프라이트 이미지의 크기
                spriteOrigin : new kakao.maps.Point(0, 0),  // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(0, 0)          // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage('', imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map);   // 지도 위에 마커를 표출
        markers.push(marker); // 배열에 생성된 마커를 추가

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거
    function removeMarker() {
        for ( var i = 0; i < markers.length; i++ ) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시하는 함수
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild (paginationEl.lastChild);
        }

        for (i=1; i<=pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "javascript:;";
            el.innerHTML = i;

            if (i===pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function(i) {
                    return function() {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 인포윈도우에 장소명을 표시 - 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;width:35px; font-size:15px;">' + title + '</div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild (el.lastChild);
        }
    }

</script>
<script>
    /* 해당 스크립트는 크게 3가지로 이루어짐 : A.리뷰 보기 , B.리뷰 작성 및 수정, C.리뷰 삭제 */
    const sessionUserId = '${sessionScope.SESSION.user.userId}';
    let selectHashtag = []; // 리뷰 해시태그 키워드 담는 배열 전역변수 선언

    /* A. 리뷰 보기 - 리뷰보기 버튼 눌렀을 때 */
    function showReviewList(places, isVisible = true) {
        const reviewList = document.getElementById('menuSearchDesc');
        reviewList.style.display = isVisible ? 'block' : 'none';

        let targetId = places.id;//레스토랑id

        $('#placeImage').empty();
        $('#placeName').text(places.place_name);
        $('#placeAddress').text(places.address_name);
        $('#placePhone').text(places.phone ? 'T.'+places.phone : '');

        //리뷰 호출
        ComUtils.callAjax("${ctx}/web/userReview/getReviewList.do", {targetId}, function(resp) {
            if (isResultOk(resp)) {
                let obj = resp.data;
                let objCnt = resp.data.length;
                let hasFileNames = false;
                let pElement = $('#placeImage');
                pElement.empty();

                /* 1. 리뷰보기시 썸네일 이미지(리뷰이미지로부터 가져옴) */
                obj.forEach(item => {
                    if (!hasFileNames && !ComUtils.isEmpty(item.fileNames)) {
                        hasFileNames = true;
                    }
                });

                if (hasFileNames) { //이미지가 있는 경우 첫 번째 이미지를 썸네일로 사용
                    obj.forEach(item => {
                        if (!ComUtils.isEmpty(item.fileNames)) {
                            let imgFileNames = item.fileNames.split(',');
                            let imgPath = `${ctx}` + GV_ASSETS_CONTENTS_URL + '/' + imgFileNames[0];
                            let imgElement = $('<img>').attr('src', imgPath).attr('alt', '추천 Place 이미지');
                            pElement.append(imgElement);
                        }
                    });
                } else { // 이미지가 없는 경우 메시지를 추가
                    pElement.append($('<p>').text('등록된 이미지가 없습니다.').addClass('no-image-class'));
                }

                /* 2. 리뷰보기시 별점 및 총 리뷰 수 */
                let ratingStar = obj.reduce((acc, curr) => acc + curr.rating, 0);
                let ratingAvg = ratingStar / objCnt; //별점 평균

                // HTML 요소 선택
                let ratingWrap = document.getElementById('placeRating');
                ratingWrap.innerHTML = ''; // 기존의 내용을 모두 지웁니다.

                // 별 아이콘 생성 및 추가
                for (let i = 1; i <= 5; i++) {
                    let starIcon = document.createElement('span');
                    starIcon.classList.add('material-icons-outlined');
                    if (i <= Math.floor(ratingAvg)) {// 가득 찬 별 아이콘
                        starIcon.textContent = 'star';
                    } else if (i - ratingAvg <= 0.5) {// 반 개의 별 아이콘
                        starIcon.textContent = 'star_half';
                    } else {// 빈 별 아이콘
                        starIcon.textContent = 'star_border';
                    }
                    ratingWrap.appendChild(starIcon);
                }

                // 평균 별점을 표시할 span 요소를 생성하여 추가
                let ratingText = document.createElement('em');
                ratingText.textContent = ratingAvg.toFixed(1); // 평균 별점을 소수 첫 번째 자리까지 표시
                ratingWrap.appendChild(ratingText);

                let reviewCnt = document.getElementById('placeReviewCnt');
                reviewCnt.textContent = '리뷰(' +objCnt+ ')';
                // $('#placeReviewCnt').text('리뷰('+objCnt+')');
                $('.fdplace-wrap .item').remove();
                    /* 3. 각 리뷰 그려주기 */
                    obj.forEach( (review, index) => {
                        let reviewImgArr = []; //리뷰이미지 담는 배열
                        let createDate = TimeUtils.displayDateFormat(review.createDate);
                        let createUser = review.createUser;
                        let createUserWithDomain = createUser.includes('@') ? createUser : createUser + '@' + sessionUserId.split('@')[1];
                        let reviewId = review.reviewId;
                        let swiperClass = "mySwiper" + index;

                        if (review.fileNames && review.fileNames.length > 0) {
                            reviewImgArr = reviewImgArr.concat(review.fileNames.split(',').map(fileName => fileName.trim()));
                        };

                        let reviewHtml =`
                            <div class="item">
                                <div class="user-info">
                                     <div class="name">
                                        익명의 맛집추적러
                                        <span>`+ createDate +`</span>
                                    </div>
                                    <div>` +
                                    (sessionUserId === createUserWithDomain ?
                                        `<button type="button" class="btn-rv" onclick="writeReview('`+reviewId+`', 'edit')">수정</button>
                                         <button type="button" class="btn-rv" onclick="deleteReview('`+reviewId+`')">삭제</button>`
                                    :
                                    ``) +
                                    `</div>
                                </div>
                                <!-- 240408수정 S -->
                                <div class="review-img swiper ` + swiperClass + `">
                                    <div class="swiper-wrapper">
                        `;
                        if (reviewImgArr.length > 0) {
                            reviewImgArr.forEach(imgFileName => {
                                reviewHtml += `
                                        <div class="swiper-slide">
                                            <img src="${ctx}` + GV_ASSETS_CONTENTS_URL +"/"+ imgFileName + `" />
                                        </div>
                                `;
                            });
                        }
                        reviewHtml += `
                                    </div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div><!-- 240408수정 E -->
                                <div class="desc">`+ review.description.replace(/(?:\r\n|\r|\n)/g,"<br>") +`</div>
                        `;
                        if (review.comCodeNm) {
                            let tagsHtml = review.comCodeNm.split(',').map(tag => `<div class="tag">`+ tag +`</div>`).join('');
                            reviewHtml += `<div class="cdNm">`+ tagsHtml +`</div>`;
                        }
                        reviewHtml += `</div>`;

                        $('.fdplace-wrap').append(reviewHtml);

                        if (reviewImgArr.length > 0) {
                            var swiper = new Swiper("." + swiperClass, {
                                spaceBetween: 30,
                                effect: "fade",
                                navigation: {
                                    nextEl: ".swiper-button-next",
                                    prevEl: ".swiper-button-prev",
                                }
                            });
                        }
                    });
                reviewLoaded = true; // 리뷰가 로드되었음을 표시
            } else {
                console.error("리뷰 데이터 가져오기 실패:", resp.error);
            }
        });
        $('#targetId').val(places.id);

    }

    /* A. 리뷰 보기 - 리뷰 등록 후 새로고침을 위해 DB Draw 분리 */
    function drawDBRestaurant() {
        // 서버에서 데이터를 가져와서 마커를 생성합니다
        ComUtils.callAjax("${ctx}/web/userRestaurant/getRestaurantList.do", {}, function(resp) {
            if (resp.result == "T") {
                // 서버에서 받은 데이터로 마커 생성
                markerData = resp.data; // 서버에서 받은 데이터
                createFavoriteMarkers();
            } else {
                console.error("데이터 가져오기 실패:", resp.error);
            }
        });
    }

    /* A. 리뷰 보기 - 리뷰보기 닫기 버튼 눌렀을 때 */
    $('.menuSearch_desc .pop-close').on('click', function(){
        $(".menuSearch_desc").animate({
                width: "toggle"
            }, 220, "linear"
        );
        resetReviewForm();
    });

    /* B. 리뷰 작성 및 수정 - 리뷰 작성 화면 리셋 함수 */
    function resetReviewForm() {
        selectHashtag = [];
        $('.review-form-box .hashTag').html('');
        fillStars(0);                   // 별점을 초기 상태로 설정 (예: 0점)
        $('#description').val('');      // 설명란을 비움
        $('.filelist-item').remove();   // 첨부파일을 비움
        $('#placeReviewCnt').text('');
        $('#rvBtn').text('리뷰등록');    // 버튼 텍스트를 기본 상태로 변경
    }

    /* B. 리뷰 작성 및 수정 - 리뷰 작성 버튼 눌렀을 때 */
    function writeReview(places, type) {
        let reviewWritePopup = document.querySelector('.menuReview-pop');
        reviewWritePopup.classList.add('show');
        resetReviewForm(); //리뷰창 리셋 함수

        let hashDivTitle = document.querySelector('.hashtag-title');
        let targetReviewId; //리뷰 수정시 리뷰아이디

        if (type === 'new') { /* 리뷰 신규 등록일 때 */
            $('#restaurantId').val(places);
            $('#reviewId').val("");
            hashDivTitle.textContent = "키워드를 골라주세요️‍👍 (1개~3개)";
            drawHashDiv();
            $('#reviewStatus').val("new");
            let fileListDiv = document.querySelector('.fh-file-list');
            if (fileListDiv) {
                fileListDiv.innerHTML = '';
            }
        } else if(type === 'edit') {/* 리뷰 수정 버튼 눌렀을 때 */
            $('#reviewId').val(places);
            hashDivTitle.textContent = "선택된 키워드‍";
            targetReviewId = places;
            $('#reviewStatus').val("edit");

            ComUtils.callAjax("${ctx}/web/userReview/getReviewList.do", {targetReviewId}, function(resp) {
                if (resp.result == "T" && !ComUtils.isEmpty(resp.result)) {
                    let obj = resp.data[0];
                    $('#reviewId').val(obj.reviewId);
                    $('#restaurantId').val(obj.restaurantId);
                    $('#hashTags').val(obj.comCodeNm);
                    $('.scoreNow').text(obj.rating);

                    let hashTagDiv = document.querySelector('.hashTag');
                        if(!ComUtils.isEmpty(obj.comCodeNm)) { //키워드(해시태그)
                            let comCode = obj.comCodeNm.split(',');
                            comCode.forEach(item => {
                                let comCodeItem = document.createElement('div');
                                comCodeItem.classList.add('hashtag-selected-item');
                                comCodeItem.textContent = item.trim();
                                hashTagDiv.appendChild(comCodeItem);
                            });
                        } else {
                            hashTagDiv.textContent = "선택된 키워드가 없습니다.";
                            hashTagDiv.style.fontSize = "small";
                            hashTagDiv.style.color = "gray";
                        }

                    fillStars(obj.rating);                  //별점
                    $('#description').val(obj.description); //내용
                    $('#rvBtn').text('리뷰수정');
                    drawFileDiv(obj);
                } else {
                    console.error("리뷰 데이터 가져오기 실패:", resp.error);
                }
            });
        }
    }

    /* B. 리뷰 작성 및 수정 - 키워드(해시태그) 그려주는 부분 */
    function drawHashDiv() {
        let reviewWritePopup = document.querySelector('.menuReview-pop');
        const hashDiv = reviewWritePopup.querySelector('.hashTag');
        // GV_CODES['R01']의 모든 요소를 반복하여 div 요소에 추가
        GV_CODES['R01'].forEach(item => {
            const hashItemDiv = document.createElement('div');
            hashItemDiv.classList.add('hashtag-item');
            hashItemDiv.textContent = "#"+item.cdNm;

            // 해시태그 항목을 클릭 가능하게 만들기
            hashItemDiv.addEventListener('click', () => {
                const index = selectHashtag.indexOf(item); // 해당 아이템의 인덱스 확인
                let selectedCount = selectHashtag.length;
                const maxSelection = 3;

                // 선택된 아이템이 아직 없는 경우 배열에 추가하고 배경색 변경
                if (index === -1) {
                    // 선택된 아이템의 수가 최대 선택 가능한 개수보다 작은 경우에만 선택 처리
                    if (selectedCount < maxSelection) {
                        selectHashtag.push(item);
                        hashItemDiv.style.backgroundColor = 'lightgray';
                    } else {
                        // 최대 선택 가능한 개수를 초과한 경우 알림 띄우기
                        alert('❗키워드는 최대 3개까지 선택 가능합니다');
                    }
                } else { // 선택된 아이템이 이미 있는 경우 배열에서 제거하고 배경색 원래대로 변경
                    selectHashtag.splice(index, 1);
                    hashItemDiv.style.backgroundColor = 'white';
                }
                //
                // hashTagNames = selectHashtag.map(item => item.cdNm);
                // hashTagNamesString = hashTagNames.join(',');
                // document.getElementById('hashTags').value = hashTagNamesString;

                console.log('Selected items:', selectHashtag);
            });

            hashDiv.appendChild(hashItemDiv);
        });
    }

    /* B. 리뷰 작성 및 수정 - 파일 첨부 그려주는 부분 */
    function drawFileDiv(data) {
        let fileListDiv = document.querySelector('.fh-file-list');
        fileListDiv.innerHTML = ''; // 파일 목록을 초기화

        if(data.fileNameList && data.attachIdList) {
            let attachIds = data.attachIdList.split(', ');
            let files = data.fileNameList.split(',');

            if (files.length > 0) {
                files.forEach((file, index) => {
                    let fileBox = document.createElement('div');
                    fileBox.classList.add('fh-file-box');

                    let fileInfo = document.createElement('span');
                    fileInfo.classList.add('fh-file-info');
                    fileInfo.textContent = file;

                    let fileToolbar = document.createElement('div');
                    fileToolbar.classList.add('fh-file-toolbar');

                    let fileRemove = document.createElement('span');
                    fileRemove.classList.add('fh-file-remove');
                    fileRemove.id = attachIds[index];
                    let removeIcon = document.createElement('i');
                    removeIcon.classList.add('fas', 'fa-times', 'fa-fw');
                    fileRemove.appendChild(removeIcon);

                    // 클릭 이벤트 리스너 추가
                    fileRemove.addEventListener('click', function () {
                        if (confirm('해당 파일을 삭제하시겠습니까?')) {
                            fileListDiv.removeChild(fileBox); // fileBox를 DOM에서 제거
                            let attachId = this.id;
                            deleteFileItem(attachId);         // 파일삭제함수 호출
                        }
                    });

                    fileToolbar.appendChild(fileRemove);

                    fileBox.appendChild(fileInfo);
                    fileBox.appendChild(fileToolbar);

                    fileListDiv.appendChild(fileBox);
                });
            }
        }
    }

    /* B. 리뷰 작성 및 수정 - 등록된 리뷰 이미지 파일 삭제 버튼 클릭시 */
    function deleteFileItem(attachIdList) {
        ComUtils.callAjax("${ctx}/web/userReview/deleteAttachImage.do", {attachId:attachIdList}, function(resp) {
            if (resp.result == "T") {
                console.log(attachIdList,"삭제됨");
                let fileItemDiv = document.getElementById(attachIdList);
                fileItemDiv.remove();
            } else {
                console.error("데이터 가져오기 실패:", resp.error);
            }
        });
    }

    /* B. 리뷰 작성 및 수정 - 등록 버튼 눌렀을 때 */
    function submitReview() {
        let placeId = $('#restaurantId').val();
        let reviewId = $('#reviewId').val();

        const hashTagNames = selectHashtag.map(item => item.cdNm);
        const hashTagCodes = selectHashtag.map(item => item.cd);

        let tagNames = hashTagNames.join(',');
        let tagCodes = hashTagCodes.join(',');

        let rating = $('.scoreNow').text();
        let reviewCntNum =  $('#placeReviewCnt').text() ? $('#placeReviewCnt').text().split('(')[1].split(')')[0] : 0;
        let reviewStatus = $('#reviewStatus').val();
        let places = restrData.get(placeId); //페이지 새로고침을 위한 변수

        //리뷰폼 유효성 검사 및 별점 체크되있는지 여부 확인
        if(ComUtils.validationCheck('reviewForm') && isStarSelected()) {
            let data = ComUtils.getParams('reviewForm', true); // 이게 리뷰데이터
            data.append('restr', JSON.stringify(restrData.get(placeId)));
            data.append('rating', rating);
            data.append('reviewCntNum', reviewCntNum);
            data.append('tagNames', tagNames);
            data.append('tagCodes', tagCodes);

            var o = $(".sus-fileupload");
            var idx = 0;
            o.find(".fh-file-info").each((function(a, e) {
                    var i = $(e)
                        , n = i.data("name")
                        , o = i.data("file");

                    n && o && data.append("file_"+(idx++), o);
                }
            ));
            $('.menuReview-pop').removeClass("show");

            //리뷰 등록
            ComUtils.callAjax("${ctx}/web/userReview/saveReview.do", data, function(resp) {
                if (resp.result == "T") {
                    if (reviewStatus == "new")
                        alert("리뷰가 등록되었습니다!");
                        resetReviewForm();
                        drawDBRestaurant();
                        placesSearchName(places.place_name)
                        showReviewList(places);
                    } else if (reviewStatus == "edit") {
                        alert("리뷰가 수정되었습니다!");
                        resetReviewForm();
                        showReviewList(places);
                } else {
                    console.error("리뷰 데이터 가져오기 실패:", resp.error);
                    alert(resp.message);
                }
            });
        } else {
            alert('별점 선택과 리뷰 내용 작성은 필수 항목입니다.');
        }
    }

    /* B. 리뷰 작성 및 수정 - 별점 초기화 */
    if ($('.ratingW').length > 0) {
        ratingStar($('.ratingW li a'));
    }

    /* B. 리뷰 작성 및 수정 - 별점 등록 */
    function ratingStar(star){
        star.click(function(){
            var stars = $('.ratingW').find('li')
            stars.removeClass('on');
            var thisIndex = $(this).parents('li').index();
            for(var i=0; i <= thisIndex; i++){
                stars.eq(i).addClass('on');
            }
            putScoreNow(thisIndex+1);
        });
    }

    /* B. 리뷰 작성 및 수정 - 별점 개수 따라 숫자 변경 */
    function putScoreNow(i){
        $('.scoreNow').html(i);
    }

    /* B. 리뷰 작성 및 수정 - 별점 수정 */
    function fillStars(rating) {
        var stars = $('#rating').find('li');

        // 별점을 1부터 5까지 반복하면서 별점을 채웁니다.
        stars.each(function(index) {
            if (index < rating) {
                $(this).addClass('on');// index가 rating보다 작으면 해당 별점에 'on' 클래스를 추가하여 별을 채운다.
            } else {
                $(this).removeClass('on');// index가 rating보다 크거나 같으면 해당 별점에 'on' 클래스를 제거하여 별을 지운다.
            }
        });
    }

    /* B. 리뷰 작성 및 수정 - 별점이 선택되었는지 확인하는 함수 */
    function isStarSelected() {
        return $('#rating li.on').length > 0;
    }

    /* C. 리뷰 삭제 - 리뷰 삭제 버튼 눌렀을 때 */
    function deleteReview(revId) {
        let restrId = $('#targetId').val();
        let restrRevId = revId;
        let reviewCnt = $('#placeReviewCnt').text();
        let reviewCntNumber = reviewCnt.split('(')[1].split(')')[0];
        let deleteMsg, data, successMsg;
        let url = "${ctx}/web/userReview/deleteReview.do";
        let places = restrData.get(restrId); //페이지 새로고침을 위한 변수

        if (reviewCntNumber == 1) { //리뷰가 1개면
            deleteMsg = "해당 리뷰를 삭제하면 식당도 맛집에서 해제됩니다. 정말 삭제하시겠어요?";
            data = {restaurantId:restrId, reviewId:restrRevId};
            successMsg = "리뷰가 삭제되고, 식당이 맛집에서 해제되었습니다.";
        } else {
            deleteMsg = "리뷰를 정말 삭제하시겠습니까?";
            data = {reviewId:revId};
            successMsg = "리뷰가 삭제되었습니다.";
        }

        if (confirm(deleteMsg)) {
            ComUtils.callAjax(url, data, function(resp) {
                if(isResultOk(resp)) {
                    alert(successMsg);
                    showReviewList(places);
                } else {
                    alert("리뷰 삭제를 실패하였습니다. 관리자에게 문의 바랍니다.");
                    console.error("데이터 가져오기 실패:", resp.error);
                }
            });
        }
    }
</script>
</c:when>
<c:otherwise>
    <script type="text/javascript">
        location.href="${ctx}/admin/login.view";
    </script>
</c:otherwise>
</c:choose>