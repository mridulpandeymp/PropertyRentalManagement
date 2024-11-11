package property_management.app.entities;

import org.springframework.web.multipart.MultipartFile;

public class Manager {
	private int experience_years;
	private MultipartFile resume;
	private int managerId;
	private boolean approved;
	private String name;
	private String mobileNo;
	private int userId;

	public Manager() {
		super();
	}

	public Manager(int experience_years, MultipartFile resume, int managerId, boolean approved) {
		super();
		this.experience_years = experience_years;
		this.resume = resume;
		this.managerId = managerId;
		this.approved = approved;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public int getExperience_years() {
		return experience_years;
	}

	public void setExperience_years(int experience_years) {
		this.experience_years = experience_years;
	}

	public MultipartFile getResume() {
		return resume;
	}

	public void setResume(MultipartFile resume) {
		this.resume = resume;
	}

	public int getManagerId() {
		return managerId;
	}

	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

}