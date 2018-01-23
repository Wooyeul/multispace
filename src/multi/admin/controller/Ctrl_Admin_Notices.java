package multi.admin.controller;
 
import java.util.List; 
import static main.Single.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import main.Controller;
import main.ModelAndView;
import main.ModelAttribute;
import main.PaginationDTO;
import main.RequestMapping;
import main.RequestParam;
import main.vo.NoticeVO;
import multi.admin.dao.Admin_FaqDAO;
import multi.admin.dao.Admin_HostDAO;
import multi.admin.dao.Admin_NoticeDAO;
import multi.admin.dao.Admin_SpaceDAO;
import multi.admin.dao.Admin_UserDAO;
import multi.admin.dao.Admin_o2oQnADAO;
import multi.admin.vo.Admin_searchVO;


/* 
�������� ����

�������� ����Ʈ Ȯ���ϱ�
�������� �ϳ� �б�
�������� �߰� ������
�������� �߰��� �̿�. �����̷�Ʈ �� �������� ����Ʈ Ȯ���ϱ� ������
�������� ���� ������. Ư�� �������� Ŭ���� ���� �޾Ƶ���.
�������� ���� ó��. �����̷�Ʈ�� Ư�� �������� �б� ������ ����
�������� ����. �����̷�Ʈ �� �������� ����Ʈ Ȯ���ϱ� ������
 */

@Controller
public class Ctrl_Admin_Notices {
	@Autowired @Qualifier("admin_NoticeDAO")
	private Admin_NoticeDAO admin_NoticeDAO = null;
	
	// �������� ����Ʈ Ȯ���ϱ�
	@RequestMapping("/admin_notice_list.do")
	public ModelAndView textList(@ModelAttribute Admin_searchVO search, @RequestParam("pg") String pg) throws Exception {
		ModelAndView mnv=new ModelAndView("admin_notice_list");
		//List<NoticeVO> rl = admin_NoticeDAO.findAll();
		//mnv.addObject("rl",rl);
		List<NoticeVO> rl = admin_NoticeDAO.search_All(search);
		PaginationDTO pz = new PaginationDTO().init(pg, rl.size()) ;
		search.setStart_no(pz.getSkip());
		rl = admin_NoticeDAO.search_All(search);
		mnv.addObject("rl", rl);
		mnv.addObject("pz", pz);
		mnv.addObject("search", search);
		
		return mnv;
	}
	// �������� �ϳ� �б�
	@RequestMapping("/admin_notice_read.do")
	public ModelAndView textRead(@ModelAttribute NoticeVO pvo) throws Exception {
		
		NoticeVO vo = admin_NoticeDAO.findByPK(pvo);
		ModelAndView mnv=new ModelAndView("admin_notice_read");
		mnv.addObject("vo",vo);

		return mnv;
	}
	// �������� �߰� ������
	@RequestMapping("/admin_notice_add.do")
	public ModelAndView textAdd(@ModelAttribute NoticeVO pvo) throws Exception {
		ModelAndView mnv=new ModelAndView("admin_notice_add");
		return mnv;
	}
	// �������� �߰��� �̿�. �����̷�Ʈ �� �������� ����Ʈ Ȯ���ϱ� ������
	@RequestMapping("/admin_notice_add2.do")
	public String textAdd2(@ModelAttribute NoticeVO pvo) throws Exception {
		admin_NoticeDAO.add(pvo);
		return "redirect:/admin_notice_list.do";
	}
	// �������� ���� ������. Ư�� �������� Ŭ���� ���� �޾Ƶ���.
	@RequestMapping("/admin_notice_mod.do")
	public ModelAndView mod(@ModelAttribute NoticeVO pvo) throws Exception {
		ModelAndView mnv=new ModelAndView("admin_notice_mod");
		mnv.addObject("vo", pvo);
		return mnv;
	}
	// �������� ���� ó��. �����̷�Ʈ�� Ư�� �������� �б� ������ ����
	@RequestMapping("/admin_notice_mod2.do")
	public String mod2(@ModelAttribute NoticeVO pvo) throws Exception {
		
		admin_NoticeDAO.mod(pvo);
		return "redirect:/admin_notice_read.do?notice_no="+pvo.getNotice_no();
	}
	// �������� ����. �����̷�Ʈ �� �������� ����Ʈ Ȯ���ϱ� ������
	@RequestMapping("/admin_notice_del.do")
	public String del(@ModelAttribute NoticeVO pvo) throws Exception {
		admin_NoticeDAO.delByPK(pvo);
		return "redirect:/admin_notice_list.do";
	}
	
}