package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestDBConnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/LibraryDB"; // Thay "LibraryDB" bằng tên database của bạn nếu cần
        String user = "root"; // Thay bằng username của MySQL
        String password = "12345678"; // Thay bằng password của MySQL

        try {
            // Load driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Kết nối đến cơ sở dữ liệu
            Connection connection = DriverManager.getConnection(url, user, password);

            if (connection != null) {
                System.out.println("Kết nối thành công với cơ sở dữ liệu!");
            } else {
                System.out.println("Kết nối thất bại.");
            }

            // Đóng kết nối sau khi thử nghiệm
            connection.close();
        } catch (ClassNotFoundException e) {
            System.out.println("Không tìm thấy driver MySQL.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Lỗi khi kết nối cơ sở dữ liệu.");
            e.printStackTrace();
        }
    }
}
