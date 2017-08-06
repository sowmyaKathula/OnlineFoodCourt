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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by sowmya on 1/19/17.
 */
@WebServlet(name = "DeleteCart")
public class DeleteCart extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int product_id = Integer.parseInt(request.getParameter("productId"));
        JSONArray jsonArray = new JSONArray();
        JSONObject obj;
        String table;
        String user;
        HttpSession session = request.getSession();
        if((session.getAttribute("user") == null) || (session.getAttribute("user") == "")){
            table = "tempcart";
            user = request.getRemoteAddr();
        }
        else{
            table = "cart";
            user = (String) session.getAttribute("user");
        }
        PrintWriter pt=response.getWriter();

        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        ResultSet rs = null;
        PreparedStatement stmt = null;
        PreparedStatement s = null;

        try{
            conn = DBConnection.createConnection();
            stmt = conn.prepareStatement(db.fetchData(new String[]{"quantity"},table,new String[]{"product_id","user"},new Object[]{product_id,user},new String("AND")));
            rs = stmt.executeQuery();
            if(rs.next()){
                if(rs.getInt(1)==1){
                    s = conn.prepareStatement("delete from "+table+" where product_id=? AND user=?");
                }
                else{
                    s = conn.prepareStatement("update "+table+" set quantity = quantity - 1 where product_id = ? AND user = ?");

                }
                s.setInt(1,product_id);
                s.setString(2,user);
                s.executeUpdate();
            }
            stmt = conn.prepareStatement(db.fetchData(new String[]{"product_name","cost","quantity"},table,new String[]{"user"},new Object[]{user},"AND"));
            rs = stmt.executeQuery();
            while(rs.next()){
                obj = new JSONObject();
                System.out.println(rs.getString(1) +" "+rs.getInt(2)+" "+rs.getInt(3));
                obj.put("product_name",rs.getString("product_name"));
                obj.put("cost",rs.getInt("cost"));
                obj.put("quantity",rs.getInt("quantity"));
                jsonArray.add(obj);
            }
            pt.print(jsonArray);

        }catch(Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
