package unit02;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

    private Connection conn;

    public MemberDAO(Connection conn) {
        this.conn = conn;
    }
    


    
    

    public int getMaxNum() {
        int maxNum = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        try {
            sql = "SELECT NVL(MAX(num), 0) FROM member";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                maxNum = rs.getInt(1);
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return maxNum;
    }

    public int insertData(MemberDTO dto) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql;
        try {
            sql = "insert into member (num, id, pwd, birth, name, email, phoneNumber, address, intro, regDate, image) "
                + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE ,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getNum());
            pstmt.setString(2, dto.getId());
            pstmt.setString(3, dto.getPwd());
            pstmt.setString(4, dto.getBirth());
            pstmt.setString(5, dto.getName());
            pstmt.setString(6, dto.getEmail());
            pstmt.setString(7, dto.getPhoneNumber());
            pstmt.setString(8, dto.getAddress());
            pstmt.setString(9, dto.getIntro());
            pstmt.setString(10, dto.getImagePath());
            
            result = pstmt.executeUpdate();
            
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return result;
    }


    public int getDataCount(String searchKey, String searchValue) {
        int totalCount = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        try {
            searchValue = "%" + searchValue + "%";
            sql = "SELECT NVL(COUNT(*), 0) FROM member WHERE " + searchKey + " LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, searchValue);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return totalCount;
    }

    public List<MemberDTO> getLists(int start, int end, String searchKey, String searchValue) {
        List<MemberDTO> lists = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        try {
            searchValue = "%" + searchValue + "%";
            sql = "SELECT * FROM ("
                + "SELECT ROWNUM rnum, data.* FROM ("
                + "SELECT num, id, pwd, birth, name, email, phoneNumber, address,intro, to_char(regDate,'YYYY-MM-DD HH:MM:SS') regDate , IMAGE "
                + "FROM member WHERE " + searchKey + " LIKE ? "
                + "ORDER BY num DESC) data) "
                + "WHERE rnum >= ? AND rnum <= ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, searchValue);
            pstmt.setInt(2, start);
            pstmt.setInt(3, end);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                MemberDTO dto = new MemberDTO();
                dto.setNum(rs.getInt("num"));
                dto.setId(rs.getString("id"));
                dto.setPwd(rs.getString("pwd"));
                String[] birth = rs.getString("birth").split("-");
                dto.setBirthYear(birth[0]);
                dto.setBirthMonth(birth[1]);
                dto.setBirthDay(birth[2]);
                dto.setName(rs.getString("name"));
                String[] email = rs.getString("email").split("@");
                dto.setEmail1(email[0]);
                dto.setEmail2(email[1]);
                String phoneNumber = rs.getString("phoneNumber");
                dto.setPhoneNumber1(phoneNumber.substring(0, 3));
                dto.setPhoneNumber2(phoneNumber.substring(3, 7));
                dto.setPhoneNumber3(phoneNumber.substring(7,11));
                dto.setAddress(rs.getString("address"));
                dto.setIntro(rs.getString("intro"));
                dto.setRegDate(rs.getString("regDate"));
                dto.setImagePath(rs.getString("image"));
                lists.add(dto);
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return lists;
    }


    public MemberDTO getReadData(int num) {
        MemberDTO dto = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        try {
            sql = "SELECT num, id, pwd, birth, name, email, phoneNumber, address, intro, regDate, IMAGE "
                + "FROM member WHERE num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new MemberDTO();
                dto.setNum(rs.getInt("num"));
                dto.setId(rs.getString("id"));
                dto.setPwd(rs.getString("pwd"));
                dto.setPwdConfirm(rs.getString("pwd"));
                String[] birth = rs.getString("birth").split("-");
                dto.setBirthYear(birth[0]);
                dto.setBirthMonth(birth[1]);
                dto.setBirthDay(birth[2]);
                dto.setName(rs.getString("name"));
                String[] email = rs.getString("email").split("@");
                dto.setEmail1(email[0]);
                dto.setEmail2(email[1]);
                String phoneNumber = rs.getString("phoneNumber");
                dto.setPhoneNumber1(phoneNumber.substring(0, 3));
                dto.setPhoneNumber2(phoneNumber.substring(3, 7));
                dto.setPhoneNumber3(phoneNumber.substring(7,11));
                dto.setAddress(rs.getString("address"));
                dto.setIntro(rs.getString("intro"));
                dto.setRegDate(rs.getString("regDate"));
                dto.setImagePath(rs.getString("image"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return dto;
    }


    public int updateData(MemberDTO dto) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql;
        try {
            sql = "UPDATE member SET id = ?, pwd = ?, birth = ?, name = ?, email = ?, phoneNumber = ?, address = ?, intro = ? , image = ? WHERE num = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPwd());
            pstmt.setString(3, dto.getBirth());
            pstmt.setString(4, dto.getName());
            pstmt.setString(5, dto.getEmail());
            pstmt.setString(6, dto.getPhoneNumber());
            pstmt.setString(7, dto.getAddress());
            pstmt.setString(8, dto.getIntro());
            pstmt.setInt(9, dto.getNum());
            pstmt.setString(10, dto.getImagePath());
            result = pstmt.executeUpdate();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return result;
    }
    

  //id 삭제
    public int deleteData_2(String id) {
        int result = 0;

        PreparedStatement pstmt = null;
        String sql;

        try {
            sql = "delete from member where id=?";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, id);

            result = pstmt.executeUpdate();

            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        return result;
    }



    
    
    //num 삭제
  	public int deleteData(int num) {
  		
  		int result = 0;
  		
  		PreparedStatement pstmt = null;
  		String sql;
  		
  		try {
  			
  			sql = "delete member where num=?";
  			
  			pstmt = conn.prepareStatement(sql);
  			
  			pstmt.setInt(1, num);
  			
  			result = pstmt.executeUpdate();
  			
  			pstmt.close();
  			
  		} catch (Exception e) {
  			System.out.println(e.toString());
  		}
  		
  		return result;
  		
  	}
    
    public boolean checkDuplicateId(String id) {
        boolean isDuplicate = false;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        try {
            sql = "SELECT COUNT(*) FROM member WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    isDuplicate = true;
                }
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return isDuplicate;
    }
    
    public String getNameByUsernameAndPassword2(String username, String password) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = null;
        
        try {
            String sql = "SELECT name FROM member WHERE id = ? AND pwd = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                name = rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return name;
    }

    public MemberDTO getNameByUsernameAndPassword(String username, String password) {
        MemberDTO dto = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        try {
        	sql = "SELECT name FROM member WHERE id = ? AND pwd = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
      
            if (rs.next()) {
                dto = new MemberDTO();
                dto.setName(rs.getString("name"));
               
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return dto;
    }
    
    

}
