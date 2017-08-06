import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * Created by sowmya on 1/12/17.
 */
@WebServlet(name = "RecordProduct")
@MultipartConfig(maxFileSize = 16177215)
public class RecordProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("sservlet product called");
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        PreparedStatement stmt = null;
        PrintWriter out= response.getWriter();
        InputStream inputStream = null;
        HttpSession st = request.getSession();
        System.out.println("---------------->");

        String product_name = request.getParameter("product_name");
        String description = request.getParameter("description");
        int cost = Integer.parseInt(request.getParameter("cost"));
        int in_stock = Integer.parseInt(request.getParameter("in_stock"));
        int type_product = Integer.parseInt(request.getParameter("type_product"));
        System.out.println("=====>");
        Part filePart = request.getPart("fileupload");
        System.out.println("**************");
        if (filePart != null) {
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
            inputStream = filePart.getInputStream();
        }
        int cat_id = Integer.parseInt(request.getParameter("selectcat"));
        int subcat_id = Integer.parseInt(request.getParameter("SubCat"));
        String phone = (String) st.getAttribute("user");
/*
* SELECT COUNT(*)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'database_name' -- the database
    AND table_name = 'table_name'
* */
        try {
            conn = DBConnection.createConnection();
            stmt=conn.prepareStatement("insert into product(`product_name`, `description`, `cost`, `instock`, `product_type`, `image`, `cat_id`, `subcat_id`, `phone`) values(?,?,?,?,?,?,?,?,?)");
            stmt.setString(1,product_name);
            stmt.setString(2,description);
            stmt.setInt(3,cost);
            stmt.setInt(4,in_stock);
            stmt.setInt(5,type_product);
            stmt.setBlob(6,inputStream);
            stmt.setInt(7,cat_id);
            stmt.setInt(8,subcat_id);
            stmt.setString(9,phone);

            stmt.executeUpdate();
            out.print("1");
        }catch(Exception e){
            e.printStackTrace();

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
