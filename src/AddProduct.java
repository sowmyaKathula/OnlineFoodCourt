import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

/**
 * Created by sowmya on 1/10/17.
 */
@WebServlet(name = "AddProduct")
public class AddProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("------>");
        PrintWriter pt=response.getWriter();
        HttpSession st= request.getSession();
        JSONArray jsonArray = new JSONArray();
        JSONObject obj;
        String phone = (String) st.getAttribute("user");
        int cat=Integer.parseInt(request.getParameter("cat"));
        System.out.println("------>"+phone +" "+cat);
        CustomDatabase db = new CustomDatabase();
        Connection myConn=DBConnection.createConnection();
        try {
            PreparedStatement stmt = myConn.prepareStatement(db.fetchData(new String[]{"sub_cat","subcat_id"},"subcatg",new String[]{"cat_id","phone"},new Object[]{cat,phone},"AND"));
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                System.out.println(rs.getString("sub_cat" )+"---------->"+rs.getInt("subcat_id"));
                obj = new JSONObject();
                obj.put("sub_cat",rs.getString("sub_cat"));
                obj.put("subcat_id",rs.getInt("subcat_id"));
                jsonArray.add(obj);
            }
            pt.print(jsonArray);
            /*for (Object obj1 : jsonArray) {
                JSONObject x = (JSONObject) obj1;
                System.out.println("cloudcover : " +x.get("sub_cat"));
                System.out.println("humidity : " + x.get("subcat_id"));
            }*/
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
