<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,util.*" contentType="text/html;charset=euc-kr" %>

<%! 
	Connection DB_Connection() throws ClassNotFoundException, SQLException, Exception 
	{
		String url = "jdbc:oracle:thin:@xxx.xxx.xxx.xxx:1521:ORA2012";
		String username = "study";
		String userpass = "study";
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(url, username, userpass);
		return conn;
	}
%>

<%
	Connection conn = DB_Connection();
	Statement stmt = null;
	ResultSet rs = null;
	StringBuffer query = null;
	StringBuffer where = null;

	String totalCount = "";
	String link = "";
	String view_link = "";

	String page_num = Page.nullToBlank(request.getParameter("page_num"));
	String pages =  Page.nullToBlank(request.getParameter("pages"));

	String search_mode = TUtil.EregHtml(TUtil.nullToBlank(request.getParameter("search_mode")));
	String search_subject = Page.nullToBlank(request.getParameter("search_subject"));

	String search_subject_detail = TUtil.EregHtml(TUtil.nullToBlank(request.getParameter("search_subject_detail")));
	String search_name_detail = TUtil.EregHtml(TUtil.nullToBlank(request.getParameter("search_name_detail")));

	String search__start_date = TUtil.EregHtml(TUtil.nullTobaseStr( request.getParameter("search__start_date"),""));
	String search__end_date = TUtil.EregHtml(TUtil.nullTobaseStr( request.getParameter("search__end_date"),""));

	if (!pages.equals("")) link += "&pages="+pages;
	if (!page_num.equals("")) {
		link += "&page_num="+page_num;
		view_link += "&page_num="+page_num;
	}
	if(search_mode.equals("detail")) search_subject = search_subject_detail;
	if(!search_subject.equals("")) link += "&search_subject="+search_subject;
	if(!search_name_detail.equals("")) link += "&search_name_detail="+search_name_detail;
	if(!search__start_date.equals("")) link += "&search__start_date="+search__start_date;
	if(!search__end_date.equals("")) link += "&search__end_date="+search__end_date;

	int page_no = 5;
%>

<html>
<head>
<title>4�� �Խ��� ����Ʈ</title>
</head>

<style type="text/css">
/* boardcss_list ���� ���Ǵ� �� ��� ��ư ���̺� ũ�� */
#boardcss_list_add_button_table { width: 100%; margin: 0 auto 15px; /*position: relative; background: #bddcff; font-weight: bold;*/ }

/* ȭ�鿡 �������� �� ��� ��ư */
#boardcss_list_add_button_table .add_button { cursor: pointer; border: 1px solid #bebebe; position: absolute; right: 10px; top: 10px; width: 85px; padding: 6px 0 6px; text-align: center; font-weight: bold; }
#boardcss_list_add_button_table .add_button a { color: #ffffff; }

/* �� ��� ��ư�� �� ����� ��ġ�� �ʰ� ������� �ƹ��͵� �ƴѰ� */
#boardcss_list_add_button_table .boardcss_list_add_button ul { width: 100%; overflow: hidden; height: 10px;}

/* boardcss_list ���� ����ϴ� �� ��� ���̺� ũ��*/
.boardcss_list_table { width: 100%; }

/* ȭ�鿡 �������� �� ��� ���̺� */
.list_table { width: 100%; }

/* ȭ�鿡 �������� caption */
.list_table caption { display: none; }

/* list_table ���� ���Ǵ� thead */
.list_table thead th { text-align: center; border-top: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5; padding: 8px 0; background: #faf9fa; }

/* list_table ���� ���Ǵ� tbody */
.list_table tbody td { text-align: center;  border-bottom: 1px solid #e5e5e5; padding: 5px 0; }

/* boardcss_list ���� ���Ǵ� �� �˻� ���̺� ũ�� */
#boardcss_list_search { width: 100%; }

#boardcss_list_search ul{ float: right; width: 550px; display: inline; margin-right:-130px; }

#boardcss_list_search ul li { display: inline; font-weight: bold; }

/* input ���� ��� */
#search { width:200px; height:30px; text-align:center;  border: 1px solid #cfcfcf; vertical-align:middle; line-height:29px; }
#search2 { width:100px; height:30px; text-align:center;  border: 1px solid #cfcfcf; vertical-align:middle; line-height:29px; }
#search3 { width:300px; height:30px; text-align:center;  border: 1px solid #cfcfcf; vertical-align:middle; line-height:29px; }

/* �˻� ��ư */
#boardcss_list_search ul li.search_button { cursor: pointer; width: 60px; text-align: center; border: 1px solid #bebebe; padding: 6px 0 6px; vertical-align:middle; font-weight: bold; margin-right:10px; /* background: #77b32f; */ }
#boardcss_list_search ul li.search_button a { color: #ffffff; }

/* �� �˻���ư */
#boardcss_list_search ul li.detail_button { cursor: pointer; width: 100px; text-align: center;  border: 1px solid #bebebe; padding: 6px 0 6px; vertical-align:middle; font-weight: bold; /* background: #77b32f; */ }
#boardcss_list_search ul li.detail_button a { color: #ffffff; }

/* �󼼰˻� ���̺� */
.detailSearch { width: 100%; border-top: 1px solid #e5e5e5; }
.detailSearch .detailSearch_table { width: 100%; border-top: 0; border-bottom: 1px solid #e5e5e5; }

.detailSearch .detailSearch_table tbody td { padding: 5px 0; }
.detailSearch .detailSearch_table tbody td.detailSearch_td { vertical-align: middle; height: 30px; }

.detail_td { width: 100%; position: relative; height: 30px; }
.detail_td .detailSearch_button { cursor: pointer; width: 54px; position: absolute; border: 1px solid #bebebe;  padding: 6px 0 6px; text-align: center; font-weight: bold; right: 44px; display: block; /* background: #77b32f; */ }
.detail_td .detailSearch_button a { color: #ffffff; }

/* �󼼰˻� �ݱ� */
.closeButton_table { width: 100%; text-align: right; }
.closeButton { width: 85px; text-align: center; display: inline-block; border: 1px solid #bebebe; padding: 6px 0 6px; cursor: pointer; font-weight: bold; }
</style>

<script language="javascript">
function onPopup(){
	popup = window.open('/boardCSS/boardcss_write.jsp', 'boardcss_write','width=600,height=600,scrolling=no, scrollbars=no');
	popup.focus();
}

function onSearchSubmit(){
	if(document.getElementById('boardcss_list_search').style.display == 'none') frmsearch.search_mode.value = 'detail';
	else frmsearch.search_mode.value = 'main';
	frmsearch.action = '<%=request.getRequestURI() %>';
	frmsearch.taeget = '_self';
	frmsearch.submit();
}
</script>

<body>

<!-- ��Ϲ�ư ���� -->
<div id="boardcss_list_add_button_table">
	<div class="boardcss_list_add_button">
		<p class="add_button" onClick="onPopup();">���</p>
		<ul></ul>
	</div>
</div>
<!-- ��Ϲ�ư ���� -->

<!-- ���̺� ���� -->
<div class="boardcss_list_table">
	<table class="list_table">
		<caption>�Ǵ��� �̻��� �Խ���</caption>
		<colgroup>
			<col width="15%" />
			<col width="45%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th>��ȣ</th>
				<th>����</th>
				<th>�̸�</th>
				<th>�������</th>
			</tr>
		</thead>
		<tbody>
<%
	try {
		stmt = conn.createStatement();
		query = new StringBuffer();
		where = new StringBuffer();

		String contentsView = "";

		if (!search_subject.equals("")) where.append("	AND SUBJECT LIKE '%"+search_subject+"%' \n");
		if (!search_name_detail.equals("")) where.append("	AND NAME = '"+search_name_detail+"' \n");
		if (!search__start_date.equals("") && !search__end_date.equals("")) where.append("	AND TO_CHAR(REG_DATE,'YYYYMMDD') BETWEEN REPLACE('"+search__start_date+"','-','') AND REPLACE('"+search__end_date+"','-','') \n");
		else if (!search__start_date.equals("")) where.append("	AND TO_CHAR(REG_DATE,'YYYYMMDD') = REPLACE('"+search__start_date+"','-','') \n");
		else if (!search__end_date.equals("")) where.append("	AND TO_CHAR(REG_DATE,'YYYYMMDD') = REPLACE('"+search__end_date+"','-','') \n");

		query.setLength(0);
		query.append("SELECT COUNT(SEQ) TOTAL FROM NEWBOARD \n")
				.append("WHERE SEQ IS NOT NULL \n");
		query.append(where);
		rs = stmt.executeQuery(query.toString());
		if (rs.next()) {
			totalCount = rs.getString("TOTAL");
		}
		rs.close();

		if (totalCount.equals("0")) {
%>
			<tr>
				<td colspan="4">��ϵ� ���� �����ϴ�</td>
			</tr>
<%
		} else {
			query.setLength(0);
			query.append("SELECT SEQ, NAME, SUBJECT, CONTENTS, REG_DATE, RNUM \n")
					.append("FROM ( \n")
					.append("	SELECT SEQ, NAME, SUBJECT, CONTENTS, REG_DATE, ROWNUM RNUM \n")
					.append("	FROM ( \n")
					.append("		SELECT SEQ, NAME, SUBJECT, CONTENTS, TO_CHAR(REG_DATE, 'YYYY-MM-DD') REG_DATE \n")
					.append("		FROM NEWBOARD \n")
					.append("		WHERE SEQ IS NOT NULL \n");
			query.append(where);
			query.append("		ORDER BY SEQ DESC \n")
					.append("	)	) \n")
					.append("WHERE RNUM BETWEEN "+Page.pagingStatus(totalCount, page_no, page_num, "f_article")+" AND "+Page.pagingStatus(totalCount, page_no, page_num, "e_article")+" \n");
			rs = stmt.executeQuery(query.toString());

			if (page_num.equals("")) page_num = "1";
			int pageNo = Page.strToInt(page_num, 1);
			int tno = Page.strToInt(totalCount, 1);
			int no = (tno-(pageNo-1)*page_no);

			for (int i = 0; rs.next(); i++) {
				/* �ش� �κе� �ʿ���� �κ��̱� �մϴٸ�.. �����Ͻö�� ������ ���߽��ϴ�..
				StringBuffer buf = new StringBuffer();
				Reader input = rs.getCharacterStream(4);
				char[] buffer = new char[1024];
				int byteReader;
				while((byteReader = input.read(buffer,0,1024))!=-1) {
					buf.append(buffer,0,byteReader);
				}
				contentsView = Page.b_html(buf.toString(),'A');
				*/
%>

			<tr>
				<td><%=no-- %></td>
				<td><%=rs.getString("SUBJECT") %></td>
				<td><%=rs.getString("NAME") %></td>
				<td><%=rs.getString("REG_DATE") %></td>
			</tr>
<%
			}
		}
	} catch( Exception e ) {
		out.println( e.toString() );
	}
%>		</tbody>
	</table>
</div>
<!-- ���̺� ���� -->

<form name="frmsearch" method="post" action="<%=request.getRequestURI() %>" onSubmit="return onSearchSubmit();">
<input type="hidden" name="pages" value="<%=pages %>">
<input type="hidden" name="search_mode">

<!-- �˻� ���̺� ���� -->
<div id="boardcss_list_search" style="display:block;">
	<ul>
		<li>����</li>
		<li><input id="search" type="text" name="search_subject" value="<%=search_subject %>" style="IME-MODE:active;" /></li>
		<li class="search_button" onclick="onSearchSubmit();">�˻�</li>
		<li class="detail_button" onclick="document.getElementById('boardcss_list_search').style.display = 'none'; document.getElementById('detailSearch').style.display = 'block';">�󼼰˻���</li>
	</ul>
</div>
<!-- �˻� ���̺� ���� -->

<!-- �󼼰˻� ���̺� ���� -->
<div id="detailSearch" class="detailSearch" style="display:none;">
	<table class="detailSearch_table" summary="" border="0">
		<colgroup>
			<col width="15%" />
			<col width="30%" />
			<col width="15%" />
			<col width="40%" />
		</colgroup>
		<tbody>
			<tr>
				<th>����</th>
				<td><input id="search3" type="text" name="search_subject_detail" value="<%=search_subject_detail %>"></td>
				<th>�̸�</th>
				<td><input id="search3" type="text" name="search_name_detail" value="<%=search_name_detail %>"></td>
			</tr>
			<tr>
				<th>�������</th>
				<td colspan="2"><input id="search2" type="text" name="search__start_date" value="<%=search__start_date %>">~<input id="search2" type="text" name="search__end_date" value="<%=search__end_date %>"></td>
				<td class="detailSearch_td">
					<div class="detail_td">
						<span class="detailSearch_button" onclick="onSearchSubmit();">�˻�</span>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="closeButton_table">
		<a class="closeButton" onclick="document.getElementById('boardcss_list_search').style.display = 'block'; document.getElementById('detailSearch').style.display = 'none';">�ݱ��</a>
	</div>
</div>
<!-- �󼼰˻� ���̺� ���� -->

</form>

<!-- ������ ��� -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="40" align="center"><%=Page.paging(totalCount, page_no, page_num, request.getRequestURI(), link) %></td></tr>
</table>

</body>
</html>