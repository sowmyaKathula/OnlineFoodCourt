/**
 * Created by sowmya on 1/6/17.
 */
public class Restaurant {
    private String location;
    private String restaurantName;
    private int noOutlets;
    private String[] cuisine;
    private int restaurantid;
    public void setLocation(String l){
        this.location=l;
    }
    public void setRestaurantName(String restaurantName){
        this.restaurantName=restaurantName;
    }
    public void setNoOutlets(int n){
        this.noOutlets = n;
    }
    public void setCuisine(String[] cuisine){
        this.cuisine = cuisine;
    }
    public void setRestaurantid(int id){
        this.restaurantid=restaurantid;
    }
    public String getLocation(){
        return location;
    }
    public String getRestaurantName(){
        return restaurantName;
    }
    public int getNoOutlets(){
        return noOutlets;
    }
    public String[] getCuisine(){
        return cuisine;
    }
    public int getRestaurantid(){
        return restaurantid;
    }
}
