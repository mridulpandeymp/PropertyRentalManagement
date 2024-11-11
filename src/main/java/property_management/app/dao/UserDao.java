package property_management.app.dao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialException;

import property_management.app.entities.Manager;
import property_management.app.entities.Role;
import property_management.app.entities.User;

public interface UserDao {

	int insertUser(User user) throws IOException, SerialException, SQLException;

	int insertManager(User user, Manager manager) throws IOException, SerialException, SQLException;

	List<Role> fetchAllRoles();

	Map<String, Object> fetchPwds(String username);

	User fetchUser(String username);

	User getUserById(int userId);

	boolean updateUser(User user) throws SerialException, IOException, SQLException;

	User findByEmail(String email);

	int forgotUserPassword(String email, String passwordHash, String passwordSalt);

}
