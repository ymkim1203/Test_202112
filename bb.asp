<%
	Response.AddHeader "Cache-Control", "no-cache"
	Response.AddHeader "Expires", "0"
	Response.AddHeader "Pragma", "no-cache"
	Response.ContentType = "text/html; charset=euc-kr"
%>

1
2
3


<!-- #include virtual = "/common/inc/VarDef.asp" -->
<!-- #include virtual = "/common/inc/RSexec.asp" -->
<!-- #include virtual = "/common/inc/FunDef.asp"-->
<!-- #include file = "./mem_inc.asp"-->
<!-- #include file = "./count_inc.asp"-->
<!-- #include file="css.asp"-->


<%
	Function fncStrNum(num)
		If num < 10 Then
			fncStrNum = "000" & num
		ElseIf num < 100 Then
			fncStrNum = "00" & num
		ElseIf num < 1000 Then
			fncStrNum = "0" & num
		Else
			fncStrNum = num
		End If
	End Function

	NewNow = 0      ' 현재수량
    MaxCnt = 1000    ' 노출수량

    If app = "Y" Or (obTopTab <> "" And obTopTab <> sysTopTab) Then
        If obTopTab <> "" And obTopTab <> sysTopTab Then
        strSql = "SELECT NEWCNT = ISNULL(SUM(CASE WHEN EP_GRD_TYPE = '" & obTopTab & "' THEN 1 ELSE 0 END),0) "
        Else
        strSql = "SELECT NEWCNT = ISNULL(SUM(CASE WHEN EP_GRD_TYPE = '" & sysTopTab & "' THEN 1 ELSE 0 END),0) "
        End If
        strSql = strSql & "FROM EV_EVT_PLAN WITH(NOLOCK) "
        strSql = strSql & "WHERE EP_CNC_YN = 'N' "
        strSql = strSql & "AND EP_SEASON_CD = '" & intSeasonCd & "' "
        If obTopTab <> "" And obTopTab <> sysTopTab Then
            strSql = strSql & "AND EP_GRD_TYPE = '" & obTopTab & "' "
        Else
            strSql = strSql & "AND EP_GRD_TYPE = '" & sysTopTab & "' "
            strSql = strSql & "AND EP_APP_DT = '" & ct & "' "
        End If
        Set Rs = DBexec(strSql,"rank")
        If Not Rs.eof Then
            NewNow = Rs(0)
        End If
        Call RSClose(Rs)
    End If

	NewView = MaxCnt - NewNow

	If NewView < 1 Then
		NewView = 0
	End If

	If evt = "N" Then
		NewView = 0
	End If

	tAnsTxt = ""
    tOkFlg = "N"
    infoAgareeFlg = False
	
	If uId <> "" Then
        ' 마케팅 수신 동의 확인1
		strSql = "SELECT 1 "
		strSql = strSql & "FROM MS_MEM_DTL "
		strSql = strSql & "WHERE MD_MEM_ID ='"& uId &"' "
		strSql = strSql & "AND MD_INFOAGREE_DT IS NOT NULL "
		Set Rs = DBexec(strSql, "study")
		If Not Rs.Eof Then
			infoAgareeFlg = True
		End If
		Call DBClose(DBCon)

        ' 마케팅 수신 동의 확인2
		strSql = "SELECT COUNT(1) "
		strSql = strSql & "FROM EV_EVT_QUIZ_ANS WITH(NOLOCK) "
		strSql = strSql & "WHERE EQ_SEASON_CD = '" & intSeasonCd & "' "
		strSql = strSql & "AND EQ_MEM_ID = '" & uId & "' "
		Set Rs = DBexec(strSql,"rank")
		If Not Rs.eof Then
			If Rs(0) > 0 Then infoAgareeFlg = True
		End If
		Call RSClose(Rs)
        
        ' 퀴즈 응모 이력 확인
		strSql = "SELECT EQ_ANS_STR "
		strSql = strSql & "FROM EV_EVT_QUIZ_ANS WITH(NOLOCK) "
		strSql = strSql & "WHERE EQ_SEASON_CD = '" & intSeasonCd & "' "
        If obTopTab <> "" Then
    		strSql = strSql & "AND EQ_GRD_TYPE = '" & obTopTab & "' "
        Else
    		strSql = strSql & "AND EQ_GRD_TYPE = '" & sysTopTab & "' "
        End If
		strSql = strSql & "AND EQ_MEM_ID = '" & uId & "' "
		Set Rs = DBexec(strSql,"rank")
		If Not Rs.eof Then
			tAnsTxt = Trim(Rs(0))

            infoAgareeFlg = True
		End If
		Call RSClose(Rs)
        
        ' 당첨 이력 확인
		strSql = "SELECT COUNT(1) "
		strSql = strSql & "FROM EV_EVT_PLAN WITH(NOLOCK) "
		strSql = strSql & "WHERE EP_SEASON_CD = '" & intSeasonCd & "' "
        'If obTopTab <> "" Then
    		'strSql = strSql & "AND EP_GRD_TYPE = '" & obTopTab & "' "
        'Else
    		'strSql = strSql & "AND EP_GRD_TYPE = '" & sysTopTab & "' "
        'End If
		strSql = strSql & "AND EP_MEM_ID = '" & uId & "' "
		Set Rs = DBexec(strSql,"rank")
		If Not Rs.eof Then
			If Rs(0) > 0 Then tOkFlg = "Y"
		End If
		Call RSClose(Rs)
	End If
    
	Function FncQstImg(no)
		Select Case no
			Case "1" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> 메가스터디 최초 통합 모의고사의 이름은?</span><span class='questionBox--hint'>(힌트: ㅁㅁㅁㅁ 모의고사)</span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : QUEL</span>"
                End If
			Case "2" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> PREQUEL 수능을 ㅁㅁㅁㅁ.</span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : 미리보다</span>"
                End If
			Case "3" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> SEQUEL 수능에 ㅁㅁㅁㅁㅁ.</span><span class='questionBox--hint'></span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : 가까워지다</span>"
                End If
			Case "4" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> 메가스터디가 만든 최초의 통합 모의고사<br>QUEL 모의고사의 총 과목 수는?</span><span class='questionBox--hint'>(힌트 : 국어 | 수학 | 영어 | 생활과 윤리 | 사회&middot;문화 |<br>물리학Ⅰ&middot;Ⅱ | 화학 Ⅰ&middot;Ⅱ | 생명과학 Ⅰ&middot;Ⅱ | 지구과학 Ⅰ&middot;Ⅱ)</span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : 13</span>"
                End If
			Case "5" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> QUEL 모의고사는<br>국어, 수학, 영어, 사회탐구, 과학탐구Ⅰ·Ⅱ<br>ㅁ ㅁㅁ 모의고사 입니다.</span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : 전 영역</span>"
                End If
			Case "6" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> QUEL 모의고사는 ㅁㅁㅁ 의도가<br>제대로 반영된 모의고사 입니다.</span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : 전 영역</span>"
                End If
			Case "7" : 
                FncQstImg = "<span class='questionBox--suject'><i>Q.</i> QUEL 모의고사는<br>메가스터디 최초 ㅁㅁ 모의고사 입니다.</span>"

                If NewView = 0 Then
                    FncQstImg = FncQstImg & "<span class='questionBox--answer'>정답 : 통합</span>"
                End If
		End Select
	End Function

	If uId = "chakr84" Then
		Response.Write "<div style='text-align:left; padding-top:20px; padding-left:450px; color:#fff;'>"
		Response.Write "sysTopTab : <span style='color:white;'>" & sysTopTab & "</span><br/>"
		Response.Write "obTopTab : <span style='color:white;'>" & obTopTab & "</span><br/>"
		Response.Write "현재수량 : <span style='color:white;'>" & NewView & "</span><br/>"
		Response.Write "---------------------------------------------------------------------------------------------------------------------------<br/>"
		Response.Write "NowFullDt : <span style='color:white;'>" & NowFullDt & "</span><br/>"
		Response.Write "app : <span style='color:white;'>" & app & "</span><br/>"
		Response.Write "---------------------------------------------------------------------------------------------------------------------------<br/>"
		Response.Write "준비 이미지 노출 여부 : <span style='color:white;'>" & rdy & "</span><br/>"
		Response.Write "현재 시간 정답 : <span style='color:white;'>" & qstAns & "</span><br/>"
		Response.Write "서비스 상태 : <span style='color:white;'>" & service_flg & "</span><br/>"
		Response.Write "</div>"
	End If
%>
<div class="conWrap">
	<div class="clickTabWrap">
		<ul class="clickTabWrap__list">
            <% If obTopTab <> "" Then %>
                <li<% If obTopTab = 1 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(1);"><span>5/10(월)</span></a></li>
                <li<% If obTopTab = 2 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(2);"><span>5/11(화)</span></a></li>
                <li<% If obTopTab = 3 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(3);"><span>5/12(수)</span></a></li>
                <li<% If obTopTab = 4 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(4);"><span>5/13(목)</span></a></li>
                <li<% If obTopTab = 5 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(5);"><span>5/14(금)</span></a></li>
                <li<% If obTopTab = 6 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(6);"><span>5/15(토)</span></a></li>
                <li<% If obTopTab = 7 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(7);"><span>5/16(일)</span></a></li>
            <% Else %>
                <li<% If sysTopTab = 1 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(1);"><span>5/10(월)</span></a></li>
                <li<% If sysTopTab = 2 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(2);"><span>5/11(화)</span></a></li>
                <li<% If sysTopTab = 3 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(3);"><span>5/12(수)</span></a></li>
                <li<% If sysTopTab = 4 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(4);"><span>5/13(목)</span></a></li>
                <li<% If sysTopTab = 5 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(5);"><span>5/14(금)</span></a></li>
                <li<% If sysTopTab = 6 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(6);"><span>5/15(토)</span></a></li>
                <li<% If sysTopTab = 7 Then %> class="on"<% End If %>><a href="javascript:;" onClick="fncTopTab(7);"><span>5/16(일)</span></a></li>
            <% End If %>
		</ul>
	</div>
	<!-- //clickTabWrap -->

	<!-- 상품 퀴즈 영역 -->
	<div class="event--initArea">
		<div class="quizArea">
            <% If rdy = "Y" Then %>
                <% If NowDt < 20210510 Then %>
                    <p class="event--initArea--layer2"><img src="<%=img%>/img_click_date.jpg" alt="5/10(월)부터 시작됩니다."></p>
                <% Else %>
                    <p class="event--initArea--layer2"><img src="<%=img%>/img_click_ready.jpg" alt="퀴즈는 매일 밤 10시에 공개됩니다."></p>
                <% End If %>
            <% End If %>
			<div class="pic">
				<img src="<%=img%>/img_click_gift.jpg" alt="QUEL 모의고사" >
			</div>

			<div class="write">
				<div class="questionBox">
					<div class="questionBox--table">
						<div class="questionBox--cell">
                        <% If obTopTab <> "" Then %>
                            <%=FncQstImg(obTopTab)%>
                        <% Else %>
                            <%=FncQstImg(sysTopTab)%>
                        <% End If %>
						</div>
					</div>
				</div>

                <% If tAnsTxt <> "" Then %>
                    <div class="questionInit active"><!-- 정답입력완료 -->
                        <input class="questionInit--input" type="text" name="ansStr" id="ansStr" disabled value="<%=tAnsTxt%>">
                        <a href="javascript:;">정답입력완료</a>
                    </div>
                <% Else %>
                    <div class="questionInit">
                        <input class="questionInit--input" type="text" name="ansStr" id="ansStr" value="">
                        <a href="javascript:;" onClick="<% If NewView = 0 Then %>alert('선착순 광클이 마감되었습니다.');<% Else %>fncClkAns();<% End If %>">정답입력</a>
                    </div>
                <% End If %>
			</div>
		</div>
		<!-- //quizArea -->

		<div class="applyBtn">
            <strong class="applyBtn--txt">남은 수량</strong>
            <span class="applyBtn--num">
                <span class="num"><%=Left(fncStrNum(NewView),1)%></span>
                <span class="num"><%=Mid(fncStrNum(NewView),2,1)%></span>
                <span class="num"><%=Mid(fncStrNum(NewView),3,1)%></span>
                <span class="num"><%=Right(fncStrNum(NewView),1)%></span>
            </span>
            <% If tOkFlg = "Y" Then %>
                <a href="javascript:;" onclick="alert('QUEL 모의고사 신청에 성공하셨습니다.'); return false;" class="applyBtn--btn"><img src="<%=img%>/btn_apply_history.png" alt="당첨 내역"></a>
            <% Else %>
                <% If NewView = 0 Then %>
                    <span class="applyBtn--btn"><img src="<%=img%>/btn_apply_done.png" alt="선착순 광클마감"></span>
                <% Else %>
                    <a href="javascript:;" class="applyBtn--btn" onclick="fncAppJoin();"><img src="<%=img%>/btn_apply_go.png" alt="선착순 광클"></a>
                <% End If %>
            <% End If %>
		</div>
		<!-- //applyBtn -->
        
        <% If NewView = 0 Then %>
		    <div class="event--initArea--done"><img src="<%=img%>/br_done.png" alt="선착순 마감"></div>
        <% End If %>
        
        <% If infoAgareeFlg = False And uId <> "" Then %>
		<div class="eventChTxt">
			<p>이벤트 참여 및 경품 발송을 위해서는 다음 내용에 동의하셔야 합니다.</p>

			<ul>
				<li>
					<strong>* 개인정보의 위탁에 대한 동의</strong><br>
					<span class="eventChTxt--c1">- 위탁 대상 : 메가스터디교육</span>
					<span class="eventChTxt--c1">- 위탁 업무 : 경품 발송</span><br>
					<span class="eventChTxt--c1">- 제공 항목 : 휴대전화번호, 주소</span>
					<span class="eventChTxt--c1">- 보유 기간 : 위탁계약 종료 시까지</span>
					<label><input type="checkbox" name="chkNum" id="chkNum"><span>동의합니다</span></label>
				</li>
			</ul>
		</div>
        <% End If %>
	</div>
	<!-- 상품 퀴즈 영역 -->
</div>

<% If MegaAdminChk = True Then %>
    <div style="text-align:center; padding:30px 0;"><input type="button" value="관리자 통계" onClick="fncAdminAx1();"></div>
    <div id="adminAx1"></div>

    <script type="text/javascript">
        function fncAdminAx1() {
            jQuery("#adminAx1").load("admin_anal_ax.asp?evtDay=<%=evtDay%>&evtFullDay=<%=evtFullDay%>");
        }
    </script>
<% End If %>

<script type="text/javascript">
<!--
    var doubleSubmitFlag = false;

    function fncAppJoin() {		
		if (doubleSubmitFlag == false){
			doubleSubmitFlag = true;

			jQuery.post("count_ax.asp", {
				<% If MegaAdminChk = True Then %>
				"evtDay": "<%=evtDay%>",
				"evtFullDay": "<%=evtFullDay%>"
				<% End If %>
			}, function (data) {
				switch (data) {
					case "login": alert("로그인 후 이용해 주세요.");fncShowLogin(); doubleSubmitFlag = false; break;
                    case "nostu": alert("해당 서비스는 학생 회원만 이용 가능합니다."); doubleSubmitFlag = false; break;
					case "end": alert("마감 되었습니다."); fncBtnArea(''); doubleSubmitFlag = false; break;
					case "pre": 
                        <% If NowDt < 20210510 Then %>
                            alert("5/10(월) 밤 10시부터 광클이 시작됩니다.");
                        <% Else %>
                            alert("선착순 광클 시작 후 클릭해주세요.");
                        <% End If %>
                        fncBtnArea('');
                        doubleSubmitFlag = false;
                        break;
					case "max":
                        <% If sysTopTab = 7 Then %>
                            alert("마감 되었습니다."); 
                        <% Else %>
                            alert("마감 되었습니다.\n다음 광클 시간에 다시 도전해 주세요."); 
                        <% End If %>
                        fncBtnArea('');
                        doubleSubmitFlag = false;
                        break;
					case "ok": alert("선착순 광클에 성공했습니다.\n당첨된 선물은 [당첨 내역]에서 확인할 수 있습니다."); fncBtnArea(''); doubleSubmitFlag = false; break;
					case "wrong": alert("퀴즈의 정답을 맞힌 후 광클에 참여해 주세요."); doubleSubmitFlag = false; break;
                    case "already": alert("이미 당첨되셨습니다."); doubleSubmitFlag = false; break;
					default: alert(data); doubleSubmitFlag = false; break;
				}
			});
		}else{
			alert("처리중 입니다.");
		}
    }

	// 퀴즈 풀기
	function fncClkAns() {
		<% If uId <> "" And infoAgareeFlg = False Then %>
		if(!jQuery("#chkNum").is(':checked')){
			alert('이벤트 참여를 위한 개인정보 항목에 동의해 주세요.');
			return false;
		}
		<% End If %>

		var ansStr = jQuery("#ansStr").val();

        try {
			var qn = "<%=CInt(qn)%>";

            jQuery.post("ans_ax.asp", 
				{
                    <% If MegaAdminChk = True Then %>
                    "evtDay": "<%=evtDay%>",
                    "evtFullDay": "<%=evtFullDay%>",
                    <% End If %>
					"ansStr" : escape(ansStr)
				}, 
				function (data) {
					switch (data) {
						case "login": alert("로그인 후 이용해 주세요.");fncShowLogin(); break;
                        case "nostu": alert("해당 서비스는 학생 회원만 이용 가능합니다."); break;
                        case "nogrd": alert("참여 대상이 아닙니다."); break;
                        case "already": alert("이미 당첨되셨습니다."); break;
						case "end": alert("선착순 광클이 마감되었습니다."); break;
						case "empty": alert("정답을 입력해 주세요."); break;
						case "quiz_ok": alert("짝짝짝! 정답입니다.\n이제 선착순 광클에 참여하실 수 있습니다."); fncBtnArea(''); break;
						case "quiz_fail": alert("틀렸습니다.\n다시 정답을 입력해주세요."); fncBtnArea(''); break;
						default: alert(data); break;
					}
				}
			);
        } catch (e) {
            return;
        }
	}
//-->
</script>