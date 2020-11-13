

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChoiceDogServlet
 */
@WebServlet("/choiceDog")
public class ChoiceDogServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChoiceDogServlet() {
        super();
        
    }

   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html; charset=utf-8");
      PrintWriter out=response.getWriter();
      String[] dog= request.getParameterValues("dog");
      out.println("<html>");
      out.println("<head>");
      out.println("</head>");
      out.println("<body bgcolor ='black'>");
      out.println("<table align ='center' bhcolor='yellow'>");
      out.println("<tr>");
      for(int i=0; i<dog.length;i++) {
         out.println("<td>");
         out.println("<img src ='"+ dog[i]+"'/>");
      out.println("</td>");
      }
      out.println("</td>");
      out.println("</table>");
      out.println("</body>");
      out.println("</html>");
      
      
      
   }

}
