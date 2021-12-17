<!DOCTYPE html>
<html lang="ko">
<!-- 공통 인클루드 페이지 시작 -->
<!-- #include virtual = "/common/inc/RSexec.asp" -->
<!-- #include virtual = "/common/inc/VarDef.asp"-->
<!-- #include virtual = "/common/inc/FunDef.asp"-->
<!-- 공통 인클루드 페이지 종료 -->

1
2
3

<%
	uId	= fncRequestCookie("userid")    ' 회원 아이디
	ViewAnc = fncRequest("ViewAnc")

	NOT_PARENTS()

    service_flg = True

	NowDt = Int(Replace(Date(),"-",""))

    If NowDt > 20210606 Then
        service_flg = False
    End If

    evt_idx = "7016"
%>



<!-- #include virtual = "/teacher_2007/t_promotion/event_view_count.asp" -->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta name="viewport" content="width=1400">
	<meta name="author" content="메가스터디(주)" />
	<meta name="keywords" content="megastudy,메가스터디,6평대비,6월모의고사,QUEL,모의고사,러셀모의고사,솟대모의고사,뉴턴과탐모의고사"/>
	<meta name="description" content="megastudy,메가스터디,6평대비,6월모의고사,QUEL,모의고사,러셀모의고사,솟대모의고사,뉴턴과탐모의고사"/>
	<title><%=window_title%></title>
	<link rel="shortcut icon" href="<%=img_common%>/megastudy.ico">
	<link type="text/css" rel="stylesheet" href="/Common/css/style.css" />
	<link type="text/css" rel="stylesheet" href="/Common/css/board_2011.css" />
	<script type="text/javascript" src="/common/js/jquery/jquery-latest_header.js"></script>
	<script type="text/javascript" src="/Common/js/megastudy.js"></script>
	<script type="text/javascript" src="/Common/js/lecture.js"></script>
	<!--#include file="css.asp"-->
</head>
<body>
<div class="column_top"><!--#include virtual="/common/menu/megaHeader.asp"--></div>

<div class="container">
	<!--#include file = "nav_quick.asp"-->

	<div class="actArea topBg">
		<div class="innerBg">
			<div class="conWrap">
                <!--#include file = "dday_timer.asp"-->
				<img src="<%=IMG%>/img_top.jpg" alt="QUEL 모의고사">
			</div>
		</div>
	</div>

	<div class="actArea cont1Bg">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_cont0101.jpg" alt="지금부터 진짜 모의고사는 QUEL 모의고사 입니다.">
			</div>
		</div>
	</div>

	<div class="actArea cont2Bg">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_cont0201.jpg" alt="단 하나뿐인 최상의 모의고사를 만들었습니다.">
				<img src="<%=IMG%>/img_cont0202.jpg" alt="전 영역 모의고사, 메가스터디 최강 선생님들의 명쾌한 해설강의">
			</div>
		</div>
	</div>

	<div class="actArea cont3Bg">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_cont0301.jpg" alt="치밀하고 전략적인 구성으로 수능을 확실하게 대비합니다.">
				<img src="<%=IMG%>/img_cont0302.jpg" alt="온라인 판매 회차 수로, 상세 판매 일정은 추후 안내할 예정입니다.">
				<!-- <img src="<%=IMG%>/img_cont0303.jpg" alt="여러분의 6평 대비, QUEL 모의고사로 시작해보세요."> -->
				<!-- 5월 20일 수동 교체 이미지 제작 필요
					<img src="<%=IMG%>/img_cont0303_2.jpg" alt="수능에 가장 가까운 모의고사, QUEL 모의고사 2021년 7월 COMING SOON"> -->
			</div>
		</div>
	</div>

	<div class="actArea eventArea">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_event0101_0517.jpg" alt="메가스터디 최초 통합 모의고사 QUEL 모의고사 출시기념 QUEL WEEK">
				<img src="<%=IMG%>/img_event0102_210520.jpg" alt="이벤트 기간 2021년 5월 10일(월) ~ 5월 16일(일) 매일 밤 10시">
				<div class="noticeWrap">
					<strong class="noticeWrap__title">※ 유의 사항 ※</strong>
					<ul class="noticeWrap__list">
						<li class="noticeWrap__list--item">매일 이벤트 시작 5분전에 퀴즈가 공개되며, 퀴즈의 정답을 입력한 뒤 참여 가능합니다.</li>
						<li class="noticeWrap__list--item">광클에 성공한 후에는 다른 일자의 참여가 불가합니다. (ID당 1회만 당첨가능)</li>
						<li class="noticeWrap__list--item">
							모의고사는 회원정보상의 기본 주소로 5/20(목)부터 순차 발송될 예정이며, 잘못된 회원정보로 인한 오발송 시 재발송 되지 않습니다.<br>
							반드시 5/18(화)까지 회원정보상의 기본 주소와 휴대전화번호가 정확한지 확인해 주시기 바랍니다.
							<a class="noticeWrap__list--link" href="javascript:;" onClick="<%If uid <> "" Then%>popMemberEdit('3')<%Else%>alert('로그인 후 이용해 주세요.'); fncShowLogin();<%End If%>">배송주소 관리 &gt;</a>
						</li>
						<li class="noticeWrap__list--item">당첨자 회원정보상의 휴대전화번호 또는 주소 정보가 없거나 회원정보가 실제와 다를 경우 당첨이 취소될 수 있습니다.</li>
						<li class="noticeWrap__list--item">부정적인 방법으로 이벤트에 참여하거나, 탈퇴하는 경우 당첨이 취소될 수 있습니다.</li>
						<li class="noticeWrap__list--item">발송일은 내부 사정에 의해 변경될 수 있습니다.</li>
						<li class="noticeWrap__list--item color-type01">영어듣기는 5/17(월)에 본 페이지에 게시 됩니다.</li>
						<li class="noticeWrap__list--item">QUEL 모의고사 내용오류, 오탈자 및 기타 문의 사항은 QUEL@megastudy.net 으로 보내주세요.</li>
					</ul>
				</div>
				<img src="<%=IMG%>/img_event0103.jpg" alt="QUEL 모의고사 정가">
                <% 'If service_flg = False Then %>
    				<div class="page_done"><img src="<%=img_main%>/common/ic_done_b.png" alt="이벤트 종료"></div>
                <% 'End If %>
			</div>
			<div id="clickArea">
                <!-- #include file = "clickArea.asp" -->
            </div>
		</div>
	</div>

	<div class="actArea cont4Bg">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_cont0401.jpg" alt="완벽한 마무리를 위한 해설강의도 무료!">
				<img src="<%=IMG%>/img_cont0402_0517.jpg" alt="QUEL 모의고사와 함께할 선생님들을 소개합니다.">
			</div>
		</div>
	</div>

	<div class="actArea cont4_2Bg">
		<div class="innerBg">
			<div class="conWrap">
				<!--강좌리스트-->
				<div id="divChrArea" class="divChrArea"></div>
				<!--강좌리스트-->
			</div>
		</div>
	</div>

	<div class="actArea eventArea02">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_event0201.jpg" alt="QUEL 모의고사에 감탄했다면? 후기 작성 GOGO!!">
				<img src="<%=IMG%>/img_event0202.jpg" alt="이벤트 기간 2021년 5월 20일(목) ~ 6월 6일(일)">
				<div class="noticeWrap">
					<strong class="noticeWrap__title">※ 유의 사항 ※</strong>
					<ul class="noticeWrap__list">
						<li class="noticeWrap__list--item">이벤트 당첨자는 후기 내용에 따라 선정하며, 정성 가득한 후기일 수록 당첨확률이 높습니다.</li>
						<li class="noticeWrap__list--item">후기 이벤트는 여러 번 참여할 수 있으나, 당첨은 ID당 1회만 가능합니다.</li>
						<li class="noticeWrap__list--item">당첨자는 최대 51명을 선정하며, 적합한 후기가 없는 경우 모두 선정하지 않을 수 있습니다.</li>
						<li class="noticeWrap__list--item">AirPods 당첨자는 22% 제세공과금 본인 부담이며, 당첨자에 한해 개별 안내 예정입니다.</li>
						<li class="noticeWrap__list--item">이벤트 혜택은 상황에 따라 사전 공지 없이 유사 금액대의 다른 상품으로 대체될 수 있습니다.</li>
						<li class="noticeWrap__list--item">
							이벤트 혜택은 회원정보상의 기본 주소와 휴대전화번호를 기준으로 발송되며, 잘못된 회원정보로 인한 오발송 시 재발송 되지 않습니다.<br>
							반드시 이벤트 참여 전 회원정보상의 기본주소와 휴대전화번호가 정확한지 확인해 주시기 바랍니다.
							<a class="noticeWrap__list--link" href="javascript:;" onClick="<%If uid <> "" Then%>popMemberEdit('3')<%Else%>alert('로그인 후 이용해 주세요.'); fncShowLogin();<%End If%>">배송주소 관리 &gt;</a>
						</li>
						<li class="noticeWrap__list--item">경품 발송을 위해 SMS 수신에 동의해주시기 바라며, 당첨자 회원정보상의 휴대전화번호 또는 주소 정보가 없거나 회원정보가 실제와 다를 경우 당첨이 취소될 수 있습니다.</li>
						<li class="noticeWrap__list--item">단순 비방이나 욕설, 무성의한 글은 공지 없이 삭제될 수 있습니다.</li>
						<li class="noticeWrap__list--item">작성하신 후기 내용은 <QUEL 모의고사> 마케팅 자료로 활용될 수 있습니다.</li>
					</ul>
				</div>
                <% If service_flg = False Then %>
                    <div class="page_done"><img src="<%=img_main%>/common/ic_done_b.png" alt="이벤트 종료"></div>
                <% End If %>

				<!--#include file="event_top.asp"-->
				<iframe src="event.asp" frameborder="0" style="width:1010px;" id="iContent" class="iContent" scrolling="no"></iframe>


			</div>
		</div>
	</div>
	<div class="actArea cont6Bg">
		<div class="innerBg">
			<div class="conWrap">
				<img src="<%=IMG%>/img_cont0601.jpg" alt="수능에 가장 가까운 모의고사, QUEL 모의고사 2021년 7월 Coming Soon">
			</div>
		</div>
	</div>

</div>
<div class="column_footer">
	<!-- 하단 메뉴 시작 -->
	<!--#include virtual="/common/menu/megaFooter.asp"-->
	<!-- 하단 메뉴 종료 -->
</div>
</body>
</html>
<script type="text/javascript" src="/common/js/jquery/jquery.countdown.js"></script>
<script type="text/javascript">
<!--
	$(window).load(function(){
		<% If ViewAnc = "eventArea02" then %>
			setTimeout(function () {
				fncGoAnchor('eventArea02');
			}, 100);
		<% Else %>
			setTimeout(function () {
				var windowScrollTop = jQuery(window).scrollTop();
				if(windowScrollTop < 270) {
				  jQuery('html, body').stop().animate({
						'scrollTop': 270
					}, 900, 'swing', function() {
					});
				}
			}, 100);
		<% End If %>

		jQuery("#divChrArea").load("CharList_Main_Season_Ax.Asp?season=7582&grd=3&lec_flg=S");
	});

	function fncGoAnchor(tg) {
		jQuery('html,body').animate({scrollTop: jQuery("."+tg).offset().top+0}, 'fast');
		return false;
	}

	function pop_open(url, name, option) {
		var pop_status;
		pop_status = window.open(url, name, option);
		pop_status.focus();
	}

	/* scroll_menu_fixed */
	jQuery(function() {
		jQuery(window).scroll(function() {
			var windowScrollTop = jQuery(window).scrollTop();
			if(windowScrollTop >= 270) {
				jQuery('.quickWrap').addClass('quick_fixed');
			} else {
				jQuery('.quickWrap').removeClass('quick_fixed');
			}
		});
	});

//-->
</script>
