import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by sowmya on 1/14/17.
 */
@WebServlet(name = "ViewProduct")
public class ViewProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter pt=response.getWriter();
        HttpSession st= request.getSession();
        JSONArray jsonArray = new JSONArray();
        JSONObject obj;
        String fileName = "image1";
        String phone = (String) st.getAttribute("user");
        int cat=Integer.parseInt(request.getParameter("cat"));
        System.out.println("------>"+phone +" "+cat);
        CustomDatabase db = new CustomDatabase();
        Connection myConn=DBConnection.createConnection();
        try {
            PreparedStatement stmt = myConn.prepareStatement(db.fetchData(new String[]{"product_name","description","cost","instock","image","product_id"}, "product", new String[]{"cat_id", "phone"}, new Object[]{cat, phone}, "AND"));
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                //System.out.println(rs.getString("sub_cat" )+"---------->"+rs.getInt("subcat_id"));
                obj = new JSONObject();
                obj.put("product_name",rs.getString("product_name"));
                obj.put("description",rs.getString("description"));
                obj.put("cost",rs.getInt("cost"));
                obj.put("instock",rs.getInt("instock"));
                byte[] imageByte = rs.getBytes("image");
                obj.put("product_id",rs.getInt("product_id"));
                String imageBase64 = DatatypeConverter.printBase64Binary(imageByte);
                obj.put("image","data:image/jpeg;base64,"+ imageBase64);
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
