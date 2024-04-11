package spring.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import spring.common.Search;
import spring.domain.User;

@Mapper
//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface UserDao {
	
	// INSERT
	public void addUser(User user) throws Exception ;

	// SELECT ONE
	public User getUser(String userId) throws Exception ;

	// SELECT LIST
	public List<User> getUserList(Search search) throws Exception ;

	// UPDATE
	public void updateUser(User user) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
}