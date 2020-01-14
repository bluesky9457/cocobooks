package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Novel;
import bean.Story;
import common.JdbcUtill;

public class NovelDetailDao {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public Novel novelDetailShow(int novelNum) {
		Novel novel=new Novel();
		String sql="SELECT * FROM NOBEL \r\n" + 
				"JOIN GENRE\r\n" + 
				"ON nobel.no_genre_num=genre.ge_num\r\n" + 
				"WHERE NO_NUM=?";
		con=JdbcUtill.getConnection();
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, novelNum);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				novel.setNovel_num(rs.getInt("NO_NUM"));
				novel.setId(rs.getNString("NO_ID"));
				novel.setTitle(rs.getNString("NO_TITLE"));
				novel.setIntro(rs.getNString("NO_TITLE"));
				novel.setGrade(rs.getNString("NO_GRADE"));
				novel.setGenre(rs.getNString("GE_NAME"));
				novel.setPay_n_free(rs.getNString("PAY_N_FREE"));
			}
			
			return novel;
			
		} catch (SQLException e) {
			System.out.println("작품 상세 목록 오류");
			e.printStackTrace();
		}
		
		
		return novel;
	}

	public List<Story> NovelDetailList(int novel_num) {
		String sql="SELECT story.sr_nobel_num NOBEL_NUM,story.sr_num STORY_NUM,story.sr_title TITLE,sr_date,sr_view_num VIEW_NUM, COUNT(recommendation.rt_story_num) REC\r\n" + 
				"FROM STORY\r\n" + 
				"LEFT JOIN recommendation\r\n" + 
				"ON story.sr_num=recommendation.rt_story_num\r\n" + 
				"GROUP BY story.sr_num, story.sr_title, sr_date, sr_view_num, story.sr_nobel_num\r\n" + 
				"HAVING story.sr_nobel_num=?\r\n" + 
				"ORDER BY SR_NUM desc";
		
		List<Story> slist=new ArrayList<Story>();
		con=JdbcUtill.getConnection();
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, novel_num);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Story st=new Story();
				st.setSR_TITLE(rs.getNString("TITLE"));
				st.setSR_DATE(rs.getDate("SR_DATE"));
				st.setSR_VIEW_NUM(rs.getInt("VIEW_NUM"));
				st.setSR_PRICE(100);
				st.setRec(rs.getInt("REC"));
				slist.add(st);
			}
			
			
		} catch (SQLException e) {
			System.out.println("소설 목록 불러오기 오류");
			e.printStackTrace();
		}
		
		return slist;
	}

}
