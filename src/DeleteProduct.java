import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Created by sowmya on 1/16/17.
 */
@WebServlet(name = "DeleteProduct")
public class DeleteProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        PreparedStatement stmt = null;
        HttpSession st= request.getSession();

        String phone = (String) st.getAttribute("user");
        int product_id = Integer.parseInt(request.getParameter("product_id"));

        try {
            conn = DBConnection.createConnection();
            stmt=conn.prepareStatement("delete from product where phone=? AND product_id=?");
            stmt.setString(1,phone);
            stmt.setInt(2,product_id);
            stmt.executeUpdate();
            RequestDispatcher rd = request.getRequestDispatcher("/EditProduct.jsp");
            rd.include(request,response);
        }catch(Exception e){
            e.printStackTrace();

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
