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
import java.sql.ResultSet;

/**
 * Created by sowmya on 1/19/17.
 */
@WebServlet(name = "ConfirmOrder")
public class ConfirmOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("user");
        PrintWriter out = response.getWriter();
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        PreparedStatement stmt = null;
        PreparedStatement s = null;

        try {
            conn = DBConnection.createConnection();
            s = conn.prepareStatement(db.fetchData(new String[]{"*"},"cart",new String[]{"user"},new Object[]{user},"AND"));
            ResultSet rs = s.executeQuery();
            while(rs.next()){
                stmt = conn.prepareStatement(db.insertData("userorder",new Object[]{rs.getString("product_name"),rs.getInt("product_id"),rs.getString("restaurant_id"),rs.getInt("cost"),rs.getInt("quantity"),rs.getString("user")}));
                stmt.executeUpdate();
            }
            s = conn.prepareStatement("delete from cart where user=?");
            s.setString(1,user);
            s.executeUpdate();
            out.print(1);

        }catch(Exception e){

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
