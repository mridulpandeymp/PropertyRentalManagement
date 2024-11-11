package property_management.app.entities;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class User {

	private int userId;
	private String firstName;
	private String lastName;
	private String emailId;
	private String mobileNo;
	private Date dateOfBirth;
	private String username;
	private String password;
	private String passwordSalt;
	private String passwordHash;
	private Role role;
	private String status;
	private MultipartFile profileImage;
	private MultipartFile idProof;

	public User() {
		super();
	}

	public User(String firstName, String lastName, String emailId, String mobileNo, Date dateOfBirth, String username,
			String status, MultipartFile profileImage, MultipartFile idProof) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailId = emailId;
		this.mobileNo = mobileNo;
		this.dateOfBirth = dateOfBirth;
		this.username = username;
		this.status = status;
		this.profileImage = profileImage;
		this.idProof = idProof;
	}

	public User(int userId, String firstName, String lastName, String emailId, String mobileNo, Date dateOfBirth,
			String username, String password, String passwordSalt, String passwordHash, Role role, String status,
			MultipartFile profileImage) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailId = emailId;
		this.mobileNo = mobileNo;
		this.dateOfBirth = dateOfBirth;
		this.username = username;
		this.password = password;
		this.passwordSalt = passwordSalt;
		this.passwordHash = passwordHash;
		this.role = role;
		this.status = status;
		this.profileImage = profileImage;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordSalt() {
		return passwordSalt;
	}

	public void setPasswordSalt(String passwordSalt) {
		this.passwordSalt = passwordSalt;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public MultipartFile getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(MultipartFile profileImage) {
		this.profileImage = profileImage;
	}

	public MultipartFile getIdProof() {
		return idProof;
	}

	public void setIdProof(MultipartFile idProof) {
		this.idProof = idProof;
	}
	
	

}
