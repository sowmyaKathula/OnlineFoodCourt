import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Random;

/**
 * Created by sowmya on 1/16/17.
 */
@WebServlet(name = "UploadImage")
@MultipartConfig(maxFileSize = 16177215)
public class UploadImage extends HttpServlet {
    private static final String SAVE_DIR="images";
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Image Servlet Called");
        Connection conn = null;
        CustomDatabase db = new CustomDatabase();
        PreparedStatement stmt = null;
        HttpSession st= request.getSession();

        String phone = (String) st.getAttribute("user");
        String savePath = "/home/sowmya/workspace/WP_Project(Fork&Knife)/web/" + SAVE_DIR;
        File fileSaveDir=new File(savePath);
        if(!fileSaveDir.exists()){
            fileSaveDir.mkdir();
        }
        Part part = request.getPart("file");
        String fileName= part.getSubmittedFileName();
        String saveFileName = savePath +File.separator + phone + fileName;
        String image =  SAVE_DIR + File.separator + phone +fileName;
        File file = new File(saveFileName);
        part.write(saveFileName);

        try {
            conn = DBConnection.createConnection();
            stmt=conn.prepareStatement("update restaurant set image=(?) where phone=(?) ");
            stmt.setString(1,image);
            stmt.setString(2,phone);
            stmt.executeUpdate();
            RequestDispatcher rd = request.getRequestDispatcher("/OwnerHome.jsp");
            rd.include(request,response);
        }catch(Exception e){
            e.printStackTrace();

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
