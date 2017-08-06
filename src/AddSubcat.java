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
import java.sql.SQLException;

/**
 * Created by sowmya on 1/9/17.
 */
@WebServlet(name = "AddSubcat")
public class AddSubcat extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter pt=response.getWriter();
        HttpSession st= request.getSession();
        String phone = (String) st.getAttribute("user");
        int cat=Integer.parseInt(request.getParameter("cat"));
        String subcat=request.getParameter("subcat");

        CustomDatabase db = new CustomDatabase();
        Connection myconn=DBConnection.createConnection();
        try {
           // System.out.println(db.insertData("subcatg(phone,cat_id,sub_cat)",new Object[]{phone,cat,subcat}));
            PreparedStatement stmt = myconn.prepareStatement(db.insertData("subcatg(phone,cat_id,sub_cat)",new Object[]{phone,cat,subcat}));
           pt.print(stmt.executeUpdate());


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
