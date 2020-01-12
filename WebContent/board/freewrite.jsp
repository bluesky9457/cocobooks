<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
#all_popup5 p.close{position:absolute;top:0px;right:18px;}
#all_popup5 p.close a{cursor:pointer}
#all_popup5 .section_tb{margin:30px 23px;padding-bottom:25px;}
#all_popup5 .section_tb1{margin:15px 23px;padding-bottom:25px;}
#all_popup5 .popup_table_sec{overflow-y:scroll;overflow-x:hidden;
 position:relative;height:586px;scrollbar-arrow-color:#d2d2d2;
 scrollbar-3dlight-color:#fff;scrollbar-highlight-color:#ccc;scrollbar-face-color:#FFF;
 scrollbar-shadow-color:#ccc;scrollbar-darkshadow-color:#fff;scrollbar-track-color:#fff}
#all_popup5 .popup_table_sec1{overflow:hidden;position:relative;height:853px;}


.popupLayer{position:absolute;top:0;left:0;z-index:100;width:100%;height:100%;
 -ms-filter:alpha(opacity=50);filter:alpha(opacity=50);opacity:0.53;-moz-opacity:0.3}
.popupLayer .back{position:absolute;top:0;left:0;z-index:101;width:100%;height:100%;background:#000}


.popup_box3{position:absolute;top:50%;left:50%;z-index:102;background:#fff}
.popup_box3 .popup_contents{position:absolute;top:0;left:0;z-index:102;width:100%;height:100%;color:#4d4d4d;}


.tb2{width:100%;border-collapse:collapse;border-top:2px solid #4d4d4d;text-align:left; table-layout:fixed;}
.tb2 th{padding:7px 0 6px 10px;border:1px solid #DDD;background:#f1f1f1;font-weight:bold;
 color:#4d4d4d;text-align:left;vertical-align:top;}
.tb2 td{padding:5px 0 4px 10px;border:1px solid #ddd;color:#4d4d4d}
.tb2 input{vertical-align:middle}
.tb2 img{padding:0 4px;vertical-align:middle}
.tb2 ul li{padding:2px 0;clear:both;width:90%;}

.popup_btn_sec{padding-top:24px;text-align:center}
.but_73{width: 60px; height: 16px; text-align: center; display: inline-block; 
 border: 1px solid #bebebe; background: #0079bc; padding: 4px 4px 4px 4px; cursor: pointer; color:#fff;font-weight: bold;}


#popup { width: 600px; }
#popup .title { position:relative; height:40px; text-align:center; width:600px; /*background: #ffffff; /*background: #008bd0;*/ }
#popup .title p{ font-weight: bold; } /* #popup .title p{ padding-top: 22px;  font-size: 20px; color:#fff; } */

.popup_write { position:absolute; /* margin-left:0px; margin-top:0px; */}
.popup_write .contents { position:absolute; }

#popup .popup_table .write_table { position:relative; height:400px; width:600px; /*background: #ffffff;*/ }

#search { width:400px; height:30px; text-align:center;  border: 1px solid #cfcfcf;
 vertical-align:middle; line-height:29px; }

.scroll_form { font-size:12px;  border: 1px solid #CDC9C9; bordescrollbar-arrow-color:#d2d2d2;
 scrollbar-3dlight-color:#fff;scrollbar-highlight-color:#ccc;scrollbar-face-color:#FFF;
 scrollbar-shadow-color:#ccc;scrollbar-darkshadow-color:#fff;scrollbar-track-color:#fff }

.addButton { width: 85px; text-align: center; display: inline-block; border: 1px solid #bebebe; 
 padding: 6px 0 6px; cursor: pointer; font-weight: bold; }
</style>

<body>
<div id="popup">
	<div class="popup_write">
		<div class="contents">
			<div class="popup_table">
				<div class="title"><p>등록</p></div>
				<div class="write_table" >
				<form name="inputForm" method="post" action="/borad/freewrite_act.jsp">
					<table summary="">
						<caption></caption>
						<colgroup>
							<col style="width:100px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td><input id="search" type="text" name="subject"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input id="search" type="text" name="name"></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea name="contents" cols="85" rows="13" class="scroll_form" style="width:400px;height:300px;"></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="popup_btn_sec"><a onClick="chkForm();"><span class="addButton">등록</span></a>&nbsp;<span class="addButton" onClick="window.close();">취소</span>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<SCRIPT LANGUAGE="JavaScript">
function chkForm()
{
  alert("등록 눌렀다");
  return false;
}
</script>
</body>
</html>