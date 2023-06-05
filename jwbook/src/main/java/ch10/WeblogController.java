package ch10;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

@WebServlet("/weblog.nhn")
public class WeblogController extends HttpServlet {
   private static final long serialVersionUID = 1L;
    
   private WeblogDAO dao;
   private ServletContext ctx;
   
   private final String START_PAGE = "ch10/weblogList.jsp";
   
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
      dao = new WeblogDAO();
      ctx = getServletContext();      
   }
   
   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      String action = request.getParameter("action");
      
      dao = new WeblogDAO();
      
      Method m;
      String view = null;
      
      if (action == null) {
         action = "listWeblog";
      }
      
      try {
         m = this.getClass().getMethod(action, HttpServletRequest.class);
         
         view = (String)m.invoke(this, request);
      } catch (NoSuchMethodException e) {
         e.printStackTrace();
         ctx.log("요청 action 없음!!");
         request.setAttribute("error", "action 파라미터가 잘못 되었습니다!!");
         view = START_PAGE;
      } catch (Exception e) {
         e.printStackTrace();
      }
   
      if(view.startsWith("redirect:/")) {
         String rview = view.substring("redirect:/".length());
         response.sendRedirect(rview);
      } else {
         RequestDispatcher dispatcher = request.getRequestDispatcher(view);
         dispatcher.forward(request, response);   
      }
   }
   
   private String putWeblog(HttpServletRequest request) {
      return "redirect:/weblog.nhn?action=showNewsPut";
   }
   
   public String showNewsPut(HttpServletRequest request) {
      return "ch10/weblogAdd.jsp";
   }
   
   public String addWeblog(HttpServletRequest request) {
      Weblog w = new Weblog();
      try {                  
         BeanUtils.populate(w, request.getParameterMap());
         dao.addWeblog(w);
      } catch (Exception e) {
         e.printStackTrace();
         ctx.log("방명록 추가 과정에서 문제 발생!!");
         request.setAttribute("error", "방명록이 정상적으로 등록되지 않았습니다!!");
         return listWeblog(request);
      }
      return "redirect:/weblog.nhn?action=listWeblog";   
   }

   public String deleteWeblog(HttpServletRequest request) {
       int aid = Integer.parseInt(request.getParameter("aid"));
      try {
         dao.delWeblog(aid);
      } catch (SQLException e) {
         e.printStackTrace();
         ctx.log("방명록 삭제 과정에서 문제 발생!!");
         request.setAttribute("error", "방명록이 정상적으로 삭제되지 않았습니다!!");
         return listWeblog(request);
      }
      return "redirect:/weblog.nhn?action=listWeblog";
   }
   
   public String listWeblog(HttpServletRequest request) {
       List<Weblog> list;
      try {
         list = dao.getAll();
         request.setAttribute("webloglist", list);
      } catch (Exception e) {
         e.printStackTrace();
         ctx.log("방명록 목록 생성 과정에서 문제 발생!!");
         request.setAttribute("error", "방명록 목록이 정상적으로 처리되지 않았습니다!!");
      }
       return "ch10/weblogList.jsp";
    }
   
   public String editWeblog(HttpServletRequest request) {
        int aid = Integer.parseInt(request.getParameter("aid"));
        try {
         Weblog w = dao.editWeblog(aid);
         request.setAttribute("weblog", w);
      } catch (SQLException e) {
         e.printStackTrace();
         ctx.log("방명록을 수정하는 과정에서 문제 발생!!");
         request.setAttribute("error", "방명록을 정상적으로 수정하지 못했습니다!!");
      }
       return "ch10/weblogEdit.jsp";
    }
}