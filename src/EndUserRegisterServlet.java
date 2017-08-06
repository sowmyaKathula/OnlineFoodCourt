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

/**
 * Created by sowmya on 1/17/17.
 */
@WebServlet(name = "EndUserRegisterServlet")
public class EndUserRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("User Servlet called");
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        ResultSet rs = null;
        PreparedStatement stmt = null;
        PrintWriter out= response.getWriter();

        String name = request.getParameter("sname");
        String phone = request.getParameter("sphone");
        String email = request.getParameter("semail");
        String password = request.getParameter("spassword");
        int type = 1;
        int count=0;

        try {
            conn = DBConnection.createConnection();
            stmt = conn.prepareStatement(db.fetchData(new String[]{"count(*)"}, "user",new String[]{"phone"},new String[]{phone},new String("AND")));
            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("---------->"+count);
            if(count==0){
                stmt=conn.prepareStatement(db.insertData("user",new Object[]{name,email,phone,password,type}));
                stmt.executeUpdate();
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
