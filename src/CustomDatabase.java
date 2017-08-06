import java.sql.Blob;
import java.sql.Connection;
import java.util.Hashtable;

/**
 * Created by sowmya on 1/8/17.
 */
public class CustomDatabase {
   // Connection con;
    public CustomDatabase(){
      //  con =DBConnection.createConnection();
    }

    // select * from table
    public String fetchData(Object[] cols,String table){
        String sql="select ";
        for (int i=0;i<cols.length-1;i++){
            sql+=cols[i]+",";
        }
        sql+=cols[cols.length-1];
        sql+=" from " + table;
        return sql;
    }


    public String fetchData(Object[] cols, String table ,String[] key,Object[] value,String operator){
        String sql=fetchData(cols,table);
        sql+=" where ";
        for (int i=0;i<key.length-1;i++){
            if(value[i] instanceof Integer)
                sql+=" "+key[i]+" = "+value[i]+" " +operator;
            else
                sql+=" "+key[i]+" = '"+value[i]+"' " +operator;
        }
        if(value[key.length-1] instanceof Integer)
            sql+=" "+key[key.length-1]+" = "+value[key.length-1];
        else
            sql+=" "+key[key.length-1]+" = '"+value[key.length-1]+"'";
        System.out.println(sql);
        return sql;
    }

    public String insertData(String table,Object[] value){
        String sql="insert into "+table+" values(";
        for(int i=0;i<value.length-1;i++){

            if(value[i] instanceof Integer)
                sql+=value[i]+",";
            else if(value[i] instanceof Blob)
                sql+=value[i]+",";
            else
                sql+="'"+value[i]+"',";
        }

        if(value[value.length-1] instanceof Integer)
            sql+=value[value.length-1]+")";
        else
            sql+="'"+value[value.length-1]+"')";
        System.out.println(sql);
        return sql;
    }


    public static void main(String[] args){
        String name="rajesh";
        int phone=123;
        System.out.println(new CustomDatabase().fetchData(new String[]{"resid", "phone"},"restaurant"));

        System.out.println(new CustomDatabase().fetchData(new String[]{"*"},"restaurant"));

        System.out.println(new CustomDatabase().fetchData(new String[]{"*"},"restaurant",new String[]{"name","phone"},new Object[]{phone,name},"AND"));
        System.out.println(new CustomDatabase().insertData("user",new Object[]{name,phone}));
    }
}
