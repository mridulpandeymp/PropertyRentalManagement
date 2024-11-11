package property_management.app.dao;

import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import property_management.app.entities.Role;
import property_management.app.entities.User;
import property_management.utility.ByteArrayMultipartFile;

public class UserRowMapper implements RowMapper<User> {

    public User mapRow(ResultSet rs, int rowNum) throws SQLException {

        User user = new User();

        user.setUserId(rs.getInt("user_id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setEmailId(rs.getString("email_id"));
        user.setMobileNo(rs.getString("mobile_no"));
        user.setDateOfBirth(rs.getDate("date_of_birth"));
        user.setUsername(rs.getString("username"));
        user.setPasswordSalt(rs.getString("passwordSalt"));
        user.setPasswordHash(rs.getString("passwordHash"));
        user.setStatus(rs.getString("status"));

        Role role = new Role();
        role.setRoleId(rs.getInt("role_id"));
        user.setRole(role);

        // Handle profile image blob
        Blob profileImageBlob = rs.getBlob("profile_image");
        if (profileImageBlob != null) {
            byte[] imageBytes = profileImageBlob.getBytes(1, (int) profileImageBlob.length());
            MultipartFile profileImage = new ByteArrayMultipartFile(imageBytes, "profileImage.jpg", "image/jpeg");
            user.setProfileImage(profileImage);
        } else {
            user.setProfileImage(null); // or handle as needed
        }

        // Handle id proof blob
        Blob idProofBlob = rs.getBlob("id_proof");
        if (idProofBlob != null) {
            byte[] idProofBytes = idProofBlob.getBytes(1, (int) idProofBlob.length());
            MultipartFile idProof = new ByteArrayMultipartFile(idProofBytes, "id_proof.jpg", "image/jpeg");
            user.setIdProof(idProof);
        } else {
            user.setIdProof(null); // or handle as needed
        }

        return user;
    }
}
