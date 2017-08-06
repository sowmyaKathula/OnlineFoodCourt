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
import java.sql.SQLException;

/**
 * Created by sowmya on 1/5/17.
 */
@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("servlet called");
        PrintWriter pt = response.getWriter();
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        System.out.println("--->" + phone + " " + password);
        String remoteaddr = request.getRemoteAddr();


        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        ResultSet rs = null;
        ResultSet r = null;
        PreparedStatement stmt = null;
        PreparedStatement s1 = null;
        PreparedStatement s2 = null;
        int flag=0;
        try {
            conn = DBConnection.createConnection();
            stmt = conn.prepareStatement(db.fetchData(new Object[]{"password","type","name"}, "user", new String[]{"phone"}, new String[]{phone}, new String("AND")));
            rs = stmt.executeQuery();
            if (rs.next()) {
                if (rs.getString("password").equals(password)) {
                    HttpSession st = request.getSession();
                    st.setAttribute("user", phone);
                    st.setAttribute("name", rs.getString("name"));
                    if(rs.getInt("type")==1) {
                        s1 = conn.prepareStatement("select * from tempcart where user = ?" );
                        s1.setString(1,remoteaddr);
                        r = s1.executeQuery();
                        while(r.next()){
                            flag=1;
                            s2 = conn.prepareStatement(db.insertData("cart",new Object[]{r.getString(1),r.getInt(2),r.getString(3),r.getInt(4),r.getInt(5),phone}));
                            s2.executeUpdate();
                        }
                        if(flag==1) {
                            s2 = conn.prepareStatement("delete from tempcart where user=?");
                            s2.setString(1, remoteaddr);
                            s2.executeUpdate();
                        }
                        pt.print(1);//End-user
                    }
                    else
                        pt.print(2);//Restaurant Owner
                }
                else
                    pt.print(0); //Login Failed
            }
            else
                pt.print(3); //Not Registered

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
