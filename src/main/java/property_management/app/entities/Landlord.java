package property_management.app.entities;

public class Landlord {

	private String landlordId;
	private User user;
	private Long id;
	private String bankDetails;
	private String upiDetails;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getBankDetails() {
		return bankDetails;
	}

	public void setBankDetails(String bankDetails) {
		this.bankDetails = bankDetails;
	}

	public String getUpiDetails() {
		return upiDetails;
	}

	public void setUpiDetails(String upiDetails) {
		this.upiDetails = upiDetails;
	}

	public Landlord() {
		super();
	}

	public Landlord(String landlordId, User user) {
		super();
		this.landlordId = landlordId;
		this.user = user;
	}

	public String getLandlordId() {
		return landlordId;
	}

	public void setLandlordId(String landlordId) {
		this.landlordId = landlordId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Landlord [landlordId=" + landlordId + ", user=" + user + "]";
	}

}