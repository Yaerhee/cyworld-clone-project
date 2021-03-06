package com.cyworld.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cyworld.dao.CyBoardDAO;
import com.cyworld.dao.CyIntroDAO;
import com.cyworld.dao.CyMemberListDAO;
import com.cyworld.dao.CyNewBoardDAO;
import com.cyworld.dao.CyProfileDAO;
import com.cyworld.dao.CyUserDAO;
import com.cyworld.dao.CyUsingItemDAO;
import com.cyworld.dao.CyVideoBoardDAO;
import com.cyworld.dao.Cyworld_pic_DAO;
import com.cyworld.dto.CyBoardMenuDTO;
import com.cyworld.dto.CyIntroDTO;
import com.cyworld.dto.CyMyItemDTO;
import com.cyworld.dto.CyPresentDTO;
import com.cyworld.dto.CyProfileDTO;
import com.cyworld.dto.CyUserDTO;
import com.cyworld.dto.CyUsingItemDTO;
import com.cyworld.dto.CyVideoMenuDTO;
import com.cyworld.dto.Cyworld_pic_menu_DTO;

@Controller("homepageControlloer")
public class HomepageController {

	@Autowired
	@Qualifier("cyIntroDAO") 
	CyIntroDAO cyIntroDAO;
	
	@Autowired
	@Qualifier("cyUserDAO")
	CyUserDAO cyUserDAO;
	
	@Autowired
	@Qualifier("cyUsingItemDAO")
	CyUsingItemDAO cyUsingItemDAO;
	
	@Autowired
	@Qualifier("cyNewBoardDAO")
	CyNewBoardDAO cyNewBoardDAO;
	
	@Autowired
	@Qualifier("cyVideoBoardDAO")
	CyVideoBoardDAO cyVideoBoardDAO;
	
	@Autowired
	@Qualifier("cyMemberListDAO")
	CyMemberListDAO cyMemberListDAO;
	
	@Autowired
	@Qualifier("cyworld_pic_DAO")
	Cyworld_pic_DAO cyworld_pic_DAO;
	
	@Autowired
	@Qualifier("cyBoardDAO")
	CyBoardDAO cyBoardDAO;

	@Autowired
	CyProfileDAO cyProfileDAO;
	
	@Autowired
	CyProfileDTO cyProfileDTO;
	
	@Autowired
	CyIntroDTO cyIntroDTO;
	
	@Autowired
	CyVideoMenuDTO cyVideoMenuDTO;
	
	@Autowired
	CyUserDTO cyUserDTO;
	
	@Autowired
	CyUsingItemDTO cyUsingItemDTO;
	
	@Autowired
	Cyworld_pic_menu_DTO cyworld_pic_menu_DTO;
	
	@RequestMapping(value="/cy/index.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String indexPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String minimi = "";
		int today = 0;
		int dotory = 0;
		int memberListCount= 0;
		int boardListCount = 0;
		// 01-08 현종 추가
		int presentList = 0;
		
		String login = request.getParameter("loginOk");
		if(login != null) {	
			cyUserDTO = (CyUserDTO) session.getAttribute("session");
			//1-5 예리 
			today = cyUserDAO.getToday(cyUserDTO.getUserId());
			CyUsingItemDTO vo = cyUsingItemDAO.useMinimi(cyUserDTO.getUserId());
			minimi = vo.getOriginalFileName();
			dotory = cyUserDAO.getDotory(cyUserDTO.getUserId());
			// 01-08 현종 추가
			presentList = cyUserDAO.getPresentList(cyUserDTO.getUserId());
			//1- 승현
			memberListCount = cyMemberListDAO.getCount(cyUserDTO.getUserId());
			boardListCount = cyNewBoardDAO.getMyListCount(cyUserDTO.getUserId());			
		}
		
		//1-6 예리
		//cyuser 조회 후 lists만큼 사이즈 설정
		//lists에 내용이 없을경우 null -> index에 출력 안됨
		//있을 경우 해당 size만큼 랜덤돌려서 index에 출력
		List<String> lists = cyIntroDAO.getAllCyuser();
		
		String[] userId = new String[lists.size()];
		
		for(int i=0; i<lists.size(); i++) {
			Random rd = new Random();
			
			if(!lists.isEmpty()) {
				int num = rd.nextInt(lists.size());
				userId[i] = lists.get(num);
				
				for(int j=0; j<i; j++) {
					if(userId[i]==userId[j]) {
						i--;
					}
				}
			}
		
		}
		
		String[] minimipic = new String[lists.size()];
		String[] userName = new String[lists.size()];

		for(int i=0; i<userId.length; i++) {
			
			if(userId[i]!=null) {
				CyUsingItemDTO vo = cyIntroDAO.useMinimi(userId[i]);
				minimipic[i] = vo.getOriginalFileName();
				userName[i] = cyUserDAO.getName(userId[i]);
			} else if(userId[i]==null) {
				minimipic[i] = null;
				userName[i] = null;
			}
		} 
		request.setAttribute("myMinimi", minimi);
		request.setAttribute("minimi", minimipic);
		request.setAttribute("userName", userName);
		request.setAttribute("userId", userId);
		request.setAttribute("dotory", dotory);
		request.setAttribute("today", today);
		request.setAttribute("boardListCount", boardListCount);
		request.setAttribute("memberListCount", memberListCount);
		// 01-08 현종 추가
		request.setAttribute("presentList", presentList);
		
		return "homepage/index";
	}
	
	@RequestMapping(value="/cy/createUser.action", method= {RequestMethod.GET,RequestMethod.POST})
	public String createUser(HttpServletRequest request) {
		
		return "homepage/createUser";
	}
	
	@RequestMapping(value="/cy/checkUser.action", method= {RequestMethod.GET,RequestMethod.POST})
	public String checkUser(HttpServletRequest request) {		

		/* 2021-01-15 현종추가 */
		if(request.getParameter("userId").matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
			request.setAttribute("chk", 2);
			request.setAttribute("idVal", request.getParameter("userId"));
			return "homepage/createUser";
		}
		
		if(cyUserDAO.idCheck(request.getParameter("userId"))==1) {
			request.setAttribute("chk", 1);
			request.setAttribute("idVal", request.getParameter("userId"));
		} else {
		request.setAttribute("chk", 0);
		request.setAttribute("idVal", request.getParameter("userId"));
		}
		
		return "homepage/createUser";
	}	
	
	@RequestMapping(value="/cy/createUser_ok.action", method= {RequestMethod.GET,RequestMethod.POST})
	public String createUser_ok(HttpServletRequest request, CyUserDTO cyUserDTO) {
		cyUserDTO.setUserDotory(300);
		cyUserDTO.setUserBirth(request.getParameter("userYear")+"-"+request.getParameter("userMonth")+"-"+request.getParameter("userDay"));
		cyUserDAO.insertData(cyUserDTO);
		insertIntro(cyUserDTO);
		insertUsingBG(cyUserDTO);
		createFolder(cyUserDTO.getUserId()); //사진첩, 게시판 폴더 만듬
		//1-6 예리 수정, 회원가입 시 게시판에 기본 폴더 생성
		cyBoardDAO.insertFolder(cyUserDTO.getUserId(), "기본 폴더", 2);
		insertUsingMinimi(cyUserDTO);
		//1-6 예리 추가 - menu dummy값 넣기
		cyUserDAO.insertMenu(cyUserDTO.getUserId());
		insertUsingFont(cyUserDTO);
		//1-7 승현 스토리룸 추가
		insertStoryRoom(cyUserDTO);
		//원석 프로필 추가
		insertProfile(cyUserDTO);
		//리다이렉트 시키기
		return "homepage/createUser_ok";
	}
	
	@RequestMapping(value="/cy/login.action", method= {RequestMethod.GET,RequestMethod.POST})
	public String signin(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		if(userId == null) {
			request.setAttribute("alert", 0);
			return "homepage/login";
		}else {
			String userPw = request.getParameter("userPw");
			int check = cyUserDAO.getCheck(userId, userPw);
			if(check==1) {
				cyUserDTO = cyUserDAO.getUserData(userId);
				HttpSession session = request.getSession();
				session.setAttribute("session", cyUserDTO);
				request.setAttribute("userId", cyUserDTO.getUserId());
				return "redirect:/cy/index.action?loginOk=ok";
			}else {
				request.setAttribute("alert", 1);
				return "homepage/login";
			}
		}
	}
	
	
	@RequestMapping(value="/cy/login_ok.action", method= {RequestMethod.GET,RequestMethod.POST})
	public String login_ok(HttpServletRequest request, String userId, String userPw) throws UnsupportedEncodingException {
		HttpSession session = request.getSession();
		cyUserDTO = cyUserDAO.getData(userId,userPw);
		
		int alert = 0;
		
		//01-06 예리 수정(데이터 없을 경우 튕겨내기)	
		alert = 2;			
		session.setAttribute("session", cyUserDTO);
		request.setAttribute("alert", alert);
		return "redirect:/cy/index.action?loginOk=ok";
	}
	
	@RequestMapping(value="/cy/logout.action", method= {RequestMethod.GET,RequestMethod.POST})
	public String logout(HttpServletRequest request, CyUserDTO cyUserDTO) {
		request.getSession().removeAttribute("session");
		request.getSession().invalidate();
		return "redirect:/cy/index.action";
	}
	
	
	public void insertIntro(CyUserDTO cyUserDTO) {
		cyIntroDTO.setUserId(cyUserDTO.getUserId());
		String gender = cyUserDTO.getUserGender();
		if(gender.equals("남자")) {
			cyIntroDTO.setOriginalFileName("/admin/pic/basic_man.jpg");
			cyIntroDTO.setSaveFileName("/admin/pic/basic_man.jpg");
		}else {
			cyIntroDTO.setOriginalFileName("/admin/pic/basic_girl.jpg");
			cyIntroDTO.setSaveFileName("/admin/pic/basic_girl.jpg");
		}
		cyIntroDTO.setTitle(cyUserDTO.getUserName()+"님의 싸이월드");
		cyIntroDTO.setIntro("자기소개가 없습니다.");
		cyIntroDTO.setToday("");
		cyIntroDAO.insertData(cyIntroDTO);
		
	}
	
	public void insertUsingBG(CyUserDTO cyUserDTO) {
		cyUsingItemDTO.setUserId(cyUserDTO.getUserId());
		String gender = cyUserDTO.getUserGender();
		if(gender.equals("남자")) {
			cyUsingItemDTO.setOriginalFileName("/admin/background/basic_man.jpg");
			cyUsingItemDTO.setSaveFileName("/admin/background/basic_man.jpg");
		}else {
			cyUsingItemDTO.setOriginalFileName("/admin/background/basic_girl.jpg");
			cyUsingItemDTO.setSaveFileName("/admin/background/basic_girl.jpg");
		}
		cyUsingItemDAO.insertBG(cyUsingItemDTO);
	}
	
	public void insertUsingMinimi(CyUserDTO cyUserDTO) {
		cyUsingItemDTO.setUserId(cyUserDTO.getUserId());
		String gender = cyUserDTO.getUserGender();
		if(gender.equals("남자")) {
			cyUsingItemDTO.setOriginalFileName("/admin/minimi/basic_man.png");
			cyUsingItemDTO.setSaveFileName("/admin/minimi/basic_man.png");
		}else {
			cyUsingItemDTO.setOriginalFileName("/admin/minimi/basic_girl.png");
			cyUsingItemDTO.setSaveFileName("/admin/minimi/basic_girl.png");
		}
		cyUsingItemDAO.insertMinimi(cyUsingItemDTO);
	}
	
	private void insertStoryRoom(CyUserDTO cyUserDTO) {
		cyUsingItemDTO.setUserId(cyUserDTO.getUserId());
		cyUsingItemDTO.setSaveFileName("/admin/room/basic_room.png");
		cyUsingItemDTO.setOriginalFileName("/admin/room/basic_room.png");
		cyUsingItemDAO.insertStoryRoom(cyUsingItemDTO);
	}
	
	public void createFolder(String userId) {
		String folder = "기본 폴더";
		File path = new File("C:/cyworld/"+userId+"/picture/"+folder);
		if(!path.exists()) path.mkdirs();
		cyworld_pic_menu_DTO.setFolderName(folder);
		cyworld_pic_menu_DTO.setFolderOrder(0);
		cyworld_pic_menu_DTO.setGroupName("");
		cyworld_pic_menu_DTO.setGroupOrder(0);
		cyworld_pic_menu_DTO.setPrivacy(2);
		cyworld_pic_menu_DTO.setUserId(userId);
		cyworld_pic_DAO.insertFolderData(cyworld_pic_menu_DTO);
		path = new File("C:/cyworld/"+userId+"/board/"+folder);
		if(!path.exists()) path.mkdirs();
        path = new File("C:/cyworld/"+userId+"/video/"+folder);
        if(!path.exists()) path.mkdirs();
        cyVideoMenuDTO.setFolderName(folder);
        cyVideoMenuDTO.setFolderOrder(0);
        cyVideoMenuDTO.setGroupName("");
        cyVideoMenuDTO.setGroupOrder(0);
        cyVideoMenuDTO.setPrivacy(2);
        cyVideoMenuDTO.setUserId(userId);
        cyVideoBoardDAO.insertFolderData(cyVideoMenuDTO);
	}
	
	public void insertProfile(CyUserDTO cyUserDTO) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int myYear = Integer.parseInt(cyUserDTO.getUserBirth().split("-")[0]);
		int age = (year - myYear)+1;
		String content = "저의 프로필입니다.<br/><br/>나의 이름은 "+cyUserDTO.getUserName()+"!!<br/><br/>";
		content += "나이는 "+age+"!! -_- "+cyUserDTO.getUserGender()+"!! <br/><br/>";
		content +="<br/>끝!!<br/><br/>";
		cyProfileDTO.setUserId(cyUserDTO.getUserId());
		cyProfileDTO.setContent(content);
		cyProfileDAO.insertData(cyProfileDTO);
	}
	
	// 선물함
		// 01-08 현종 추가
		@RequestMapping(value="/cy/popup.action", method= {RequestMethod.GET,RequestMethod.POST})
		public String presentList(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			CyUserDTO cyUserDTO = (CyUserDTO) session.getAttribute("session");
			String userId = cyUserDTO.getUserId();
			
			
			List<CyPresentDTO> lists = cyUserDAO.getPreList(userId);
			
			int[] num = new int[lists.size()];
			
			for(int i=0; i<lists.size(); i++) {
				num[i] = lists.get(i).getPresentNum(); 
			}
			
			if(lists.size() != 0) {
				List<CyMyItemDTO> lists1 = cyUserDAO.getMyItem(userId, num);
				
				
				cyUserDAO.deletePresentList(userId, num);
				
				cyUserDAO.updatePresentList(userId, lists1.size());
				
				request.setAttribute("lists", lists1);
			}
			

					
			return "homepage/popup";
		}
		
		//1-11 예리 추가
			//회원가입시 기본 폰트 넣어주기
			public void insertUsingFont(CyUserDTO cyUserDTO) {
				cyUsingItemDTO.setUserId(cyUserDTO.getUserId());
				
				cyUsingItemDTO.setSaveFileName("/admin/font/malgungothic.gif");
				cyUsingItemDTO.setOriginalFileName("/admin/font/malgungothic.css");
				
				cyUsingItemDAO.insertUsingFont(cyUsingItemDTO);
			}
				
}

