import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Created by sowmya on 1/5/17.
 */
public class DBConnection {
    public static Connection createConnection() {
        System.out.println("connection");
        Connection myConn = null;
        String url = "jdbc:mysql://localhost:3306/projectforkknife";
        String username = "root";
        String password = "root";
        try {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            }
            catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            myConn = DriverManager.getConnection(url, username, password);
            System.out.println("Connection Successfull");
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return myConn;
    }
}
