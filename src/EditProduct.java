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
@WebServlet(name = "EditProduct")
public class EditProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        PreparedStatement stmt = null;
        HttpSession st= request.getSession();

        String phone = (String) st.getAttribute("user");
        String description = request.getParameter("description");
        int cost = Integer.parseInt(request.getParameter("cost"));
        int product_id = Integer.parseInt(request.getParameter("product_id"));
        String product_name = request.getParameter("product_name");
        int in_stock = Integer.parseInt(request.getParameter("in_stock"));

        try {
            conn = DBConnection.createConnection();
            stmt=conn.prepareStatement("update product set description=?, cost=?, instock=? where phone=? AND product_id=?");
            stmt.setString(1,description);
            stmt.setInt(2,cost);
            stmt.setInt(3,in_stock);
            stmt.setString(4,phone);
            stmt.setInt(5,product_id);
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
