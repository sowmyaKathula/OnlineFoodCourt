import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by sowmya on 1/4/17.
 */
@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int count=0;
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        ResultSet rs = null;
        PreparedStatement stmt = null;
        PrintWriter out= response.getWriter();

        String location  = request.getParameter("location");
        String restaurantName  = request.getParameter("restaurantName");
        int noOutlet  = Integer.parseInt(request.getParameter("noOutlets"));
        String[] cuisine  = request.getParameterValues("cuisine[]");
        String name = request.getParameter("name");
        String contact  = request.getParameter("contact");
        String email = request.getParameter("emailaddr");
        String password = request.getParameter("password");

        try {
            conn = DBConnection.createConnection();
            stmt = conn.prepareStatement(db.fetchData(new String[]{"count(*)"}, "user",new String[]{"phone"},new String[]{contact},new String("AND")));
            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("---------->"+count);
            if(count==0){
                stmt=conn.prepareStatement(db.insertData("user",new Object[]{name,email,contact,password,0}));
                stmt.executeUpdate();
                stmt=conn.prepareStatement(db.insertData("restaurant(restaurant_name,no_Outlets,location,phone,isactivated,image)",new Object[]{restaurantName,noOutlet,location,contact,0,"restaurant.jpg"}));
                stmt.executeUpdate();
                for(String s:cuisine){
                    stmt = conn.prepareStatement(db.insertData("catg(phone,cat)",new Object[]{contact,s}));
                    stmt.executeUpdate();
                }
                out.print(1);
            }

        }
        catch(Exception e){
            e.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
